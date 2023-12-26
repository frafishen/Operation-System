import axios from 'axios';
import { API_URL } from './API_URL';

export const fetchProductOrders = async () => {
  try {
    const apiEndpoint = `${API_URL}product_order_progress`; 
    const response = await axios.get(apiEndpoint);
    return response.data;
  } catch (error) {
    console.error('Error fetching product orders:', error);
    return [];
  }
}

export const fetchProductOrderProgress = async (orderId, productId) => {
  try {
    const apiEndpoint = `${API_URL}product_order_progress/${orderId}/${productId}`;
    const response = await axios.get(apiEndpoint);
    return response.data;
  } catch (error) {
    console.error('Error fetching product order progress:', error);
    return [];
  }
};
