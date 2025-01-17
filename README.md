# Sample Web App

This is a simple web application with basic HTML, CSS, and JavaScript.

## Project Structure
sample-web-app/
├── index.html
├── style.css
├── script.js
├── SAMPLE-WEB-APP 
├── SAMPLE-WEB-APP.pub 



### Files

- **index.html**: The main HTML file that structures the web page.
- **README.md**: This file, which provides an overview of the project.
- **SAMPLE-WEB-APP**: The private SSH key file.
- **SAMPLE-WEB-APP.pub**: The public SSH key file.
- **script.js**: The JavaScript file that adds interactivity to the web page.
- **style.css**: The CSS file that styles the web page.

## Step-by-Step Instructions

### 1. Create `index.html`

The `index.html` file is the main HTML file that structures the web page. It includes the basic HTML structure and links to the CSS and JavaScript files.

2. Create style.css
The style.css file is used to style the web page. It includes basic styling for the HTML elements.


3. Create script.js

The script.js file adds interactivity to the web page. It includes a simple script that changes the message when the button is clicked.

4. Add SSH Key Files
The SAMPLE-WEB-APP and SAMPLE-WEB-APP.pub files contain SSH keys. These keys are used for secure communication and authentication. Ensure these files are kept secure and not exposed publicly.

SAMPLE-WEB-APP: The private SSH key file.
SAMPLE-WEB-APP.pub: The public SSH key file.

Security Note
The SAMPLE-WEB-APP and SAMPLE-WEB-APP.pub files contain sensitive SSH key information. Ensure these files are kept secure and not exposed publicly.

5. Create Dockerfile
The Dockerfile defines the Docker image for the web application. It uses a lightweight Nginx base image and copies the web application files to the web server's root directory.

6. Install Docker
Download Docker Desktop for Windows:

Go to the Docker Desktop for Windows download page.
Click on the "Download for Windows" button.
Install Docker Desktop:

Run the downloaded installer.
Follow the installation instructions.
During the installation, ensure that the option to use WSL 2 instead of Hyper-V is selected if you are using Windows Subsystem for Linux 2.
Start Docker Desktop:

After the installation is complete, start Docker Desktop from the Start menu.
Docker Desktop will take a few moments to start up.
Verify the Installation:

Open a new Command Prompt or PowerShell window.
Run the following command to verify that Docker is installed correctly:


7. Build and Run the Docker Container
 
 1. Navigate to the Directory: Open a terminal and navigate to the directory containing your Dockerfile. 
```cd /c/Users/user/sample-web-app/sample_web_app```
 2. Build the Docker Image: Run the following command to build the Docker image:
 ```docker build -t sample-web-app .```
 3. Run the Docker Container: Run the following command to start the Docker container:
```docker run -d -p 80:80 sample-web-app```

8. Bonus Sub-task: Use Docker Compose for a Multi-Container Setup

1. Create a docker-compose.yml File

2. Run the Multi-Container Setup
Start the Docker Compose environment:
```docker-compose up -d```
This will build the web service and start the container.

