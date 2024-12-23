import 'package:flutter/material.dart';

const Color customOrange = Color(0xFFFF7F00);
const Color customGrey = Colors.grey;
const double borderRadius = 8.0;

const List<String> dimensionUnits = ['cm', 'mm', 'm'];
const List<String> goodsTypes = [
  'Select',
  'Electronics',
  'Clothing',
  'Food',
  'Furniture',
  'Other',
];

const List<String> countries = [
  'China',
  'Tanzania',
  'India',
  'United States',
  'Germany',
  'Brazil',
  'Canada',
  'Kenya',
  'Australia',
  'South Africa'
];

const Map<String, List<String>> countryCityMap = {
  'China': ['Beijing', 'Shanghai'],
  'Tanzania': ['Dar es Salaam', 'Arusha'],
  'India': ['Mumbai', 'New Delhi'],
  'United States': ['New York', 'Los Angeles'],
  'Germany': ['Berlin', 'Munich'],
  'Brazil': ['Sao Paulo', 'Rio de Janeiro'],
  'Canada': ['Toronto', 'Vancouver'],
  'Kenya': ['Nairobi', 'Mombasa'],
  'Australia': ['Sydney', 'Melbourne'],
  'South Africa': ['Cape Town', 'Johannesburg'],
};

const Map<String, List<String>> sameContinentCountries = {
  'China': ['India'],
  'Tanzania': ['Kenya'],
  'India': ['China'],
  'United States': ['Canada'],
  'Germany': ['France'],
  'Brazil': ['Argentina'],
  'Canada': ['United States'],
  'Kenya': ['Tanzania'],
  'Australia': [],
  'South Africa': ['Namibia'],
};

const List<String> portCities = [
  'Dar es Salaam',
  'Shanghai',
  'Mumbai',
  'New York',
  'Los Angeles',
  'Berlin',
  'Sao Paulo',
  'Toronto',
  'Cape Town',
  'Sydney'
];
