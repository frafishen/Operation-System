import os

from flask import (Flask, redirect, render_template, request,
                   send_from_directory, url_for, jsonify)
import psycopg2
import psycopg2.extras

from utils import calculate_growth_rates


app = Flask(__name__)
app.config['DEBUG'] = True

DATABASE_NAME = 'os_db'
USER = 'mis_g1'
PASSWORD = 'mis'
HOST = 'db'
PORT = 5432


@app.route('/')
def index():
   print('Request for index page received')
   print("test Hello")
#    return render_template('index.html')
   return 'HI'


@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')

@app.route('/hello', methods=['POST'])
def hello():
   name = request.form.get('name')

   if name:
       print('Request for hello page received with name=%s' % name)
       return render_template('hello.html', name = name)
   else:
       print('Request for hello page received with no name or blank name -- redirecting')
       return redirect(url_for('index'))


def get_db_connection():
    conn = psycopg2.connect(database=DATABASE_NAME, user=USER, password=PASSWORD, host=HOST, port=PORT)
    return conn

@app.errorhandler(500)
def handle_500(error):
    app.logger.error(f"500 error: {error}")  # Log the error
    return jsonify({"status": "failed", "message": "Internal server error"}), 500


# client
@app.route('/client', methods=['GET'])
def get_client():
    conn = get_db_connection()
    query = 'SELECT * FROM client'
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)



# CLIENT SEARCH BAR
##################################################################
@app.route('/client/<id>', methods=['GET'])
def search_client(id):
    conn = get_db_connection()
    query = f'SELECT * FROM client WHERE client_id = {id}'
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)
##################################################################
##################################################################



# PPT P.11
##################################################################
@app.route('/client/revenue/<id>', methods=['GET'])
def get_company_revenue(id):
    conn = get_db_connection()
    query = f'SELECT client_id, revenue FROM client_revenue WHERE client_id = {id};'
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]

    return jsonify(result)

@app.route('/client/revenue_growth_rates/<id>', methods=['GET'])
def get_revenue_growth_rates(id):
    conn = get_db_connection()
    query = f'SELECT client_id, revenue FROM client_revenue WHERE client_id = {id};'
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    result[0]['growth rates'] = calculate_growth_rates(result[0]['revenue'])

    return jsonify(result)

@app.route('/client/average_purchase_interval/<id>', methods=['GET'])
def get_average_purchase_interval(id):
    conn = get_db_connection()
    query = f'SELECT client_id, avg_purchase_interval FROM average_purchase_interval WHERE client_id = {id};'
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    
    return jsonify(result)
##################################################################
##################################################################



# inventory
##################################################################
@app.route('/inventory', methods=['GET'])
def get_inventory():
    conn = get_db_connection()
    product_query = '''SELECT p.product_id, p.product_name, p.quantity, rp.required_pid AS required_product_id
                       FROM product p
                       INNER JOIN required_product rp ON p.product_id = rp.produced_pid;'''
    material_query = 'SELECT material_id, material_name, quantity FROM material'
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(product_query)
        product_data = cursor.fetchall()
        cursor.execute(material_query)
        material_data = cursor.fetchall()
    product_result = [dict(row) for row in product_data]
    material_result = [dict(row) for row in material_data]

    return jsonify({"product": product_result, "material": material_result})

@app.route('/inventory/product/<id>', methods=['GET'])
def get_product_consumption_prediction(id):
    conn = get_db_connection()
    query = f'SELECT * FROM product_inventory_consumption WHERE product_id = {id}'
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)

@app.route('/inventory/material/<id>', methods=['GET'])
def get_material_consumption_prediction(id):
    conn = get_db_connection()
    query = f'SELECT * FROM material_inventory_consumption WHERE material_id = {id}'
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)
##################################################################
##################################################################



# product order progress
@app.route('/product_order_progress', methods=['GET'])
def get_product_orders():
    conn = get_db_connection()
    query = '''SELECT co.order_id, 
                    ocp.product_id, 
                    p.product_name, 
                    m.machine_id, 
                    co.created_at AS order_created_at, 
                    co.delivered_at AS order_delivered_at
                FROM client_order co
                INNER JOIN order_contain_product ocp ON co.order_id = ocp.order_id
                INNER JOIN product p ON ocp.product_id = p.product_id
                INNER JOIN model m ON p.model_id = m.model_id;
                '''
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)

@app.route('/product_order_progress/<product_type>', methods=['GET'])
def get_certain_type_product_orders(product_type):
    conn = get_db_connection()
    print(product_type, type(product_type))
    query = f'''SELECT 
                    co.order_id, 
                    ocp.product_id, 
                    p.product_name, 
                    m.machine_id, 
                    co.created_at AS order_created_at, 
                    co.delivered_at AS order_delivered_at
                FROM 
                    client_order co
                INNER JOIN 
                    order_contain_product ocp ON co.order_id = ocp.order_id
                INNER JOIN 
                    product p ON ocp.product_id = p.product_id
                INNER JOIN 
                    model m ON p.model_id = m.model_id
                WHERE 
                    p.product_type = '{product_type}';'''
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)

@app.route('/product_order_progress/<id>/<product_id>', methods=['GET'])
def get_product_order_progress(id, product_id):
    conn = get_db_connection()
    query = f'''SELECT co.progress 
                FROM client_order co 
                INNER JOIN order_contain_product ocp ON co.order_id = ocp.order_id 
                WHERE co.order_id = {id} AND ocp.product_id = {product_id};'''
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)


# material order progress
@app.route('/material_order_progress', methods=['GET'])
def get_material_orders():
    conn = get_db_connection()
    query = '''SELECT 
                    mo.material_order_id, 
                    m.material_name, 
                    ocm.quantity, 
                    mo.created_at, 
                    mo.delivered_at, 
                    mo.progress
               FROM 
                    material_order mo
               JOIN 
                    order_contain_material ocm ON mo.material_order_id = ocm.material_order_id
               JOIN 
                    material m ON ocm.material_id = m.material_id;'''
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)

@app.route('/material_order_progress/<id>/<material_id>', methods=['GET'])
def get_material_order_progress(id, material_id):
    conn = get_db_connection()
    query = f'''SELECT mo.progress 
                FROM material_order mo
                INNER JOIN order_contain_material ocm ON mo.material_order_id = ocm.material_order_id 
                WHERE mo.material_order_id = {id} AND ocm.material_id = {material_id};'''
    
    with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
    result = [dict(row) for row in data]
    return jsonify(result)

if __name__ == '__main__':
#    from waitress import serve
#    serve(app, host='0.0.0.0', port=80)
#    app.run()
    app.run(host='0.0.0.0', port=80)
