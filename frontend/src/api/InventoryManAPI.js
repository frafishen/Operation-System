import axios from 'axios';
import { API_URL } from './API_URL';

export const fetchInventory = async () => {
  try {
    const apiEndpoint = `${API_URL}inventory`; 
    const response = await axios.get(apiEndpoint);
    const { product, material } = response.data;
    // return { product, material };
    return product;

  } catch (error) {
    console.error('Error fetching inventory:', error);
    return { product: [], material: [] };
  }
};

export const fetchProductOrderProgress = async (productId) => {
  try {
    const apiEndpoint = `${API_URL}inventory/product/${productId}`; 
    const response = await axios.get(apiEndpoint);
    // console.log(response.data);
    return response.data;
  } catch (error) {
    console.error('Error fetching product order progress:', error);
    return [];
  }
};