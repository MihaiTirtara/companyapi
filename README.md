# companyapi
This is a REST API written in Ruby with Sinatra. The web API has as objects companies and owners, it can be comsumed using curl or the client available at this link:https://github.com/MihaiTirtara/rubyClient.
The API is hosted with Heroku at the following link: https://ancient-escarpment-92868.herokuapp.com
## Routes
The following methods are available:

### POST /companies
 ```
 curl -d "name=company_name & adress=company_adress & city=company_city & country=company_country & email=company_email & phoneNumber=company_phoneNumber" https://ancient-escarpment-92868.herokuapp.com/companies
 ```
 This will add a new company. The fields: Name,Adress,City and Country are required.

### GET /companies
 ```
 curl https://ancient-escarpment-92868.herokuapp.com/companies
 ```
 This will return  a list with the companies
 
 ### GET /companies/:id
 ```
 curl https://ancient-escarpment-92868.herokuapp.com/companies/id
 ```
 This will return the details for a specific company.
 
  ### DELETE /companies/:id
 ```
 curl -X DELETE https://ancient-escarpment-92868.herokuapp.com/companies/id
 ```
 This will delete a specific company.
 
 ### PATCH /companies/:id
 ```
 curl -X PATCH -d "company[name]=newCompany_name & company[adress]=newCompany_adress " https://ancient-escarpment-92868.herokuapp.com/companies/id
 ```
 This will edit the fields from a specific company.
 
 ### POST /owners
 ```
 curl -d "name=owner_name & company_id=company_id " https://ancient-escarpment-92868.herokuapp.com/owners
 ```
 This will add a new owner to a company . The required fields are Name and the ID of the company (The company must be already existing).
