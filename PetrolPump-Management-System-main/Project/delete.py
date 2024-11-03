import pandas as pd
import streamlit as st
from database import *

# Delete function template
def delete_item(entity_name, view_func, view_unique_func, delete_func, columns):
    result = view_func()
    df = pd.DataFrame(result, columns=columns)
    with st.expander(f"View all {entity_name}"):
        st.dataframe(df)

    unique_list = [i[0] for i in view_unique_func()]
    selected_item = st.selectbox(f"Select {entity_name} to delete", unique_list)
    st.warning(f"Do you want to delete {entity_name} with ID: {selected_item}?")
    
    if st.button(f"Delete {entity_name}"):
        delete_func(selected_item)
        st.success(f"{entity_name} has been deleted successfully!")
    
    result2 = view_func()
    df2 = pd.DataFrame(result2, columns=columns)
    with st.expander(f"Updated {entity_name} data"):
        st.dataframe(df2)

# Specific delete functions
def delete_for_Petrolpump():
    delete_item(
        entity_name="Petrolpump",
        view_func=view_all_Petrolpump_data,
        view_unique_func=view_only_Registration_No,
        delete_func=delete_data_Petrolpump,
        columns=['Registration_No','Petrolpump_Name','Company_Name','Opening_Year','State','City']
    )

def delete_for_Owners():
    delete_item(
        entity_name="Owner",
        view_func=view_all_Owners_data,
        view_unique_func=view_only_Owner_Name,
        delete_func=delete_data_Owners,
        columns=['Owner_Name', 'Contact_NO', 'DOB', 'Gender', 'Address', 'Partnership']
    )

def delete_for_Employee():
    delete_item(
        entity_name="Employee",
        view_func=view_all_Employee_data,
        view_unique_func=view_only_Employee_ID,
        delete_func=delete_data_Employee,
        columns=['Employee_ID', 'Emp_Name', 'Emp_Gender', 'Designation', 'DOB', 'Salary', 'Emp_Address', 'Email_ID', 'Petrolpump_No', 'Manager_ID']
    )

def delete_for_Customer():
    delete_item(
        entity_name="Customer",
        view_func=view_all_Customer_data,
        view_unique_func=view_only_Customer_Code,
        delete_func=delete_data_Customer,
        columns=['Customer_Code', 'C_Name', 'Phone_No', 'Email_ID', 'Gender', 'City', 'Age']
    )

def delete_for_Invoice():
    delete_item(
        entity_name="Invoice",
        view_func=view_all_Invoice_data,
        view_unique_func=view_only_Invoice_No,
        delete_func=delete_data_Invoice,
        columns=['Invoice_No', 'Date', 'Invoice_Type', 'Fuel_Amount', 'Fuel_Type', 'Discount', 'Total_Price', 'Customer_Code']
    )

def delete_for_Tanker():
    delete_item(
        entity_name="Tanker",
        view_func=view_all_Tanker_data,
        view_unique_func=view_only_Tanker_ID,
        delete_func=delete_data_Tanker,
        columns=['Tanker_ID', 'Capacity', 'Pressure', 'Fuel_ID', 'Fuel_Amount', 'Fuel_Name', 'Fuel_Price', 'Petrolpump_No']
    )
