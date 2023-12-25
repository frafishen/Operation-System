import axios from 'axios';
import { API_URL } from './API_URL';

export const fetchMaterialOrders = async () => {
  try {
    const apiEndpoint = `${API_URL}material_order_progress`; 
    const response = await axios.get(apiEndpoint);
    // console.log("Current mode:", process.env.NODE_ENV);
    // console.log("API URL:", API_URL);
    // console.log("Response data:", response.data)
    return response.data;
  } catch (error) {
    console.error('Error fetching material orders:', error);
    return [];
  }
};


