# Sample Web Application

This is a simple web application built with HTML, CSS, and JavaScript, complemented by Docker for containerization. Below is a structured guide to help you understand and implement the project seamlessly.

---

## Project Structure
```
sample-web-app/
├── index.html           # Main HTML file
├── style.css            # CSS file for styling
├── script.js            # JavaScript file for interactivity
├── SAMPLE-WEB-APP       # Private SSH key file
├── SAMPLE-WEB-APP.pub   # Public SSH key file
```

---

## File Descriptions

### **index.html**
The core HTML file that structures the web page and links to the CSS and JavaScript files.

### **style.css**
Defines the styles and layout of the web page, ensuring a visually appealing design.

### **script.js**
Contains JavaScript logic to add interactivity, such as event handling for user actions.

### **SAMPLE-WEB-APP & SAMPLE-WEB-APP.pub**
These are SSH key files used for secure communication and authentication.
- **SAMPLE-WEB-APP**: Private SSH key (keep secure).
- **SAMPLE-WEB-APP.pub**: Public SSH key.

---

## Step-by-Step Guide

### **1. Create the Files**

#### **index.html**
Define the structure of the web page and include links to style.css and script.js:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sample Web App</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Welcome to the Sample Web App</h1>
    <button id="changeMessage">Click Me!</button>
    <p id="message">Hello, World!</p>
    <script src="script.js"></script>
</body>
</html>
```

#### **style.css**
Create basic styling for your web page:
```css
body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 0;
    padding: 0;
    background-color: #f4f4f9;
}

h1 {
    color: #333;
}

button {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}

p {
    color: #555;
}
```

#### **script.js**
Add JavaScript for user interaction:
```javascript
document.getElementById('changeMessage').addEventListener('click', () => {
    document.getElementById('message').textContent = 'You clicked the button!';
});
```

---

### **2. Add SSH Key Files**
Place the `SAMPLE-WEB-APP` (private key) and `SAMPLE-WEB-APP.pub` (public key) securely in the project directory. Ensure these files are protected and not exposed publicly.

---

### **3. Create a Dockerfile**
Define a Dockerfile to containerize your application:
```dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
```

---

### **4. Install Docker**

#### Steps to Install Docker Desktop:
1. **Download**:
   - Visit the [Docker Desktop](https://www.docker.com/products/docker-desktop/) page.
   - Choose the version for your OS.

2. **Install**:
   - Run the installer and follow the prompts.
   - If using Windows, select "WSL 2" instead of Hyper-V during installation.

3. **Start Docker**:
   - Launch Docker Desktop from your applications menu.

4. **Verify Installation**:
   - Open a terminal and run:
     ```sh
     docker --version
     ```

---

### **5. Build and Run the Docker Container**

#### Steps:
1. Navigate to the project directory:
   ```sh
   cd /path/to/sample-web-app
   ```

2. Build the Docker image:
   ```sh
   docker build -t sample-web-app .
   ```

3. Run the container:
   ```sh
   docker run -d -p 80:80 sample-web-app
   ```

---

### **6. Bonus: Use Docker Compose for Multi-Container Setup**

#### **Create a `docker-compose.yml` File**
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "80:80"
```

#### **Start the Multi-Container Setup**
Run:
```sh
docker-compose up -d
```
This builds and runs your application in a Docker Compose environment.

---

## Security Note
Ensure sensitive files, such as `SAMPLE-WEB-APP` and `SAMPLE-WEB-APP.pub`, are not exposed to public repositories or unauthorized users. Use `.gitignore` to exclude them from version control.

```gitignore
SAMPLE-WEB-APP
SAMPLE-WEB-APP.pub