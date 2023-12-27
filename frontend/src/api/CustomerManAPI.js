import axios from 'axios';
import { API_URL } from './API_URL';

export const fetchClients = async () => {
  try {
    const apiEndpoint = `${API_URL}client`; 
    const response = await axios.get(apiEndpoint);
    return response.data;
  } catch (error) {
    console.error('Error fetching client data:', error);
    return [];
  }
};

export const fetchClientById = async (clientId) => {
    try {
      const apiEndpoint = `${API_URL}client/${clientId}`;
      const response = await axios.get(apiEndpoint);
      return response.data;
    } catch (error) {
      console.error('Error fetching client data by ID:', error);
      return [];
    }
  };
  
  export const fetchCompanyRevenue = async (clientId) => {
    try {
      const apiEndpoint = `${API_URL}client/revenue/${clientId}`;
      const response = await axios.get(apiEndpoint);
      return response.data;
    } catch (error) {
      console.error('Error fetching company revenue:', error);
      return [];
    }
  };
  
  export const fetchRevenueGrowthRates = async (clientId) => {
    try {
      const apiEndpoint = `${API_URL}client/revenue_growth_rates/${clientId}`;
      const response = await axios.get(apiEndpoint);
      return response.data;
    } catch (error) {
      console.error('Error fetching revenue growth rates:', error);
      return [];
    }
  };

  export const fetchAveragePurchaseInterval = async (clientId) => {
    try {
      const apiEndpoint = `${API_URL}client/average_purchase_interval/${clientId}`;
      const response = await axios.get(apiEndpoint);
      return response.data;
    } catch (error) {
      console.error('Error fetching average purchase interval:', error);
      return [];
    }
  };
  