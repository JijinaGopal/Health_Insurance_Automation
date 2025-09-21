#!/usr/bin/env python
# coding: utf-8

# In[21]:


import numpy as np
import pandas as pd
import seaborn as sns


# In[49]:


df=pd.read_csv(r"C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\health_insurance_dataset.csv")
df


# In[ ]:





# In[136]:


df.dtypes


# In[ ]:





# In[ ]:


#convert Claimdate to Date format
df['ClaimDate']=pd.to_datetime(df['ClaimDate'])


# In[ ]:





# In[36]:


df.dtypes


# In[ ]:





# In[ ]:





# In[10]:


df.head(2)


# In[ ]:





# In[144]:


df.shape


# In[ ]:





# In[ ]:





# In[51]:


#check for null
df.isnull().sum()


# In[37]:


x=df[df['ClaimID'].isnull()]
x


# In[154]:


#Check for duplicates
df.duplicated().sum()


# In[156]:


#Rows and columns
df.shape


# In[ ]:





# ##### Feature Engineering

# In[52]:


df['Year']=df['ClaimDate'].dt.year


# In[53]:


df['Month']=df['ClaimDate'].dt.month


# In[54]:


df['Day']=df['ClaimDate'].dt.day


# In[7]:


df.head(2)


# In[183]:


df.dtypes


# In[ ]:





# In[55]:


df_1=df[df['ClaimStatus']!='Pending']
df_1=df_1.drop(['ClaimID','PatientID','ProviderID','ClaimDate'],axis=1)
df_1.head(2)


# In[ ]:





# In[98]:


#Rows and columns
df_1.shape


# In[ ]:





# In[56]:


#Convert categorical columns to Numerical
from sklearn.preprocessing import LabelEncoder
columns_to_encode=['DiagnosisCode','ProcedureCode','PatientGender','ProviderSpecialty','PatientMaritalStatus','PatientEmploymentStatus','ProviderLocation','ClaimStatus','ClaimType','ClaimSubmissionMethod']
encoders = {}
for i in columns_to_encode:
    lb=LabelEncoder()
    df_1[i]=lb.fit_transform(df_1[i])
    encoders[i] = lb


# In[ ]:





# In[102]:


df_1.head(2)


# In[ ]:





# In[42]:


#Correlation check
corr_matrix=df_1.corr()
corr_matrix


# In[ ]:





# In[221]:


sns.heatmap(corr_matrix,annot=True)


# In[ ]:





# In[223]:


#Outliers
sns.boxplot(df_1['ClaimAmount'])


# In[ ]:





# In[23]:


sns.boxplot(df_1['PatientAge'])


# In[ ]:





# In[24]:


sns.boxplot(df_1['PatientIncome'])


# In[ ]:





# In[57]:


df_1.columns


# In[ ]:





# In[106]:


df_1.head(2)


# In[ ]:





# In[58]:


df_1=df_1[['ClaimAmount', 'DiagnosisCode', 'ProcedureCode', 'PatientAge',
       'PatientGender', 'ProviderSpecialty', 'PatientIncome',
       'PatientMaritalStatus', 'PatientEmploymentStatus', 'ProviderLocation',
       'ClaimType', 'ClaimSubmissionMethod', 'Year', 'Month', 'Day', 'ClaimStatus']]
df_1.head(2)


# In[ ]:





# In[59]:


#Standardization
from sklearn.preprocessing import StandardScaler
ss=StandardScaler()
X_data=df_1.iloc[ :  ,: -1]
y_data=df_1['ClaimStatus']
X_std=ss.fit_transform(X_data)
X_std=pd.DataFrame(X_std)
X_std


# In[ ]:





# In[60]:


#Data Splitting
from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X_std,y_data,test_size=0.2,random_state=34)
X_train.shape,X_test.shape,y_train.shape,y_test.shape


# In[30]:


#Model Building


# In[61]:


#Logistic Regression
from sklearn.linear_model import LogisticRegression
lR=LogisticRegression(C=0.01,max_iter=50,penalty='l2')
lR.fit(X_train,y_train)


# In[ ]:


y_predict=lR.predict(X_test)
y_predict


# In[ ]:





# In[63]:


y_predict.shape


# In[34]:


#Model Evaluation


# In[64]:


from sklearn.metrics import accuracy_score,precision_score,recall_score,f1_score

accuracy = accuracy_score(y_test,y_predict)
precision = precision_score(y_test,y_predict)
recall = recall_score(y_test,y_predict)
f1 = f1_score(y_test,y_predict)
accuracy,precision,recall,f1


# In[ ]:


metrics = {
    'Accuracy': accuracy_score(y_test, y_predict),
    'Precision': precision_score(y_test, y_predict),
    'Recall': recall_score(y_test, y_predict),
    'F1 Score': f1_score(y_test,y_predict),
}


# In[ ]:


metrics_df = pd.DataFrame([metrics])
metrics_df.to_csv('LogsticRegression_model_metrics.csv', index=False)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:



 


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




