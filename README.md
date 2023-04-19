# Employee list project
## Simple employee accounting system 
### - Architecture -
This project was written using Redux (UDF) approach. This is example of the self written architecture way to support different states, reduce actions and get only one single source of the truth (data).
### - Requirements -
This project was written in SwiftUI as a modern and popular framework that offered by Apple company.
### - Simple description - 
1. Form to add new employee with fileds: first name, last name, gender, birth date picker, salary and employee's department. This form shows as modal screen and involves that all fields are required.
2. Employees list view to show all workers, sorted in sections by the department. Each row shows employee's first and last name, date of birth and his salary.
3. Employyes list view shows search bar at the top of the view. It allows search employee by his first or last name ignoring letters case.
4. Each section has the header with department title and button 'info' to show department's detail info. It shows title, workers count and average salary.
5. All data stored in the JSON file, stored on the disk. There was integrated Persistance service to allow this logic. When application is launching, this service loads JSON file to get employees data. When user adding any new employee, service updates JSON data and save it.

### - Time estimation -
Implementation all the logic that described above, took near 5-6 hours at all. 

### - Original requirements link -
https://docs.google.com/document/d/1Xcv0eYQp83J7cmbH8dJpUMLa-yAZOnliQS6TlKq3jvQ/edit