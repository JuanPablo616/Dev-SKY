# 📌 DEVSKY_APP

Aplicación web desarrollada con enfoque en **gestión y administración**, construida con tecnologías modernas para garantizar escalabilidad, seguridad y facilidad de uso.  

## 🚀 Características principales
- ✅ Interfaz moderna e intuitiva.  
- ✅ Conexión entre **frontend y backend** de manera fluida.  
- ✅ CRUD completo (crear, leer, actualizar y eliminar registros).  
- ✅ Persistencia de datos en **MySQL**.  
- ✅ Arquitectura modular y escalable.  
- ✅ Configuración a través de archivos `.properties`.  

---

## 🛠️ Tecnologías utilizadas
- **Frontend**: HTML, CSS, JavaScript Vanilla  
- **Backend**: Node.js con **mysql2**  
- **Base de datos**: MySQL  
- **Servidor de desarrollo**: Web Logic  
- **Gestión de dependencias**: npm  

---

## 📂 Estructura del proyecto
```
DEVSKY_APP/
│── frontend/       # Archivos HTML, CSS y JS
│── backend/        # Código del servidor Node.js
│── database/       # Scripts SQL y configuraciones
│── config/         # Archivos .properties para conexión
│── package.json    # Dependencias del proyecto
│── README.md       # Documentación
```

---

## ⚙️ Instalación y ejecución

### 1️⃣ Clonar el repositorio
```bash
git clone https://github.com/tu-usuario/DEVSKY_APP.git
cd DEVSKY_APP
```

### 2️⃣ Instalar dependencias
```bash
npm install
```

### 3️⃣ Configurar base de datos
1. Crear la base de datos en MySQL:  
   ```sql
   CREATE DATABASE devsky_app;
   ```
2. Importar el esquema desde `database/schema.sql`.  

### 4️⃣ Configurar variables
Editar `config/app.properties` con tus credenciales:
```properties
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=devsky_app
```

### 5️⃣ Levantar el servidor
```bash
node backend/server.js
```

El proyecto correrá en:  
👉 `http://localhost:3000`

---

## 📊 Scripts disponibles
- `npm start` → Inicia el servidor en producción  
- `npm run dev` → Inicia el servidor en modo desarrollo  

---

## 👨‍💻 Contribución
1. Haz un **fork** del proyecto  
2. Crea una rama (`git checkout -b feature-nueva`)  
3. Realiza tus cambios y haz commit (`git commit -m "Agrego nueva feature"`)  
4. Haz push a tu rama (`git push origin feature-nueva`)  
5. Abre un **Pull Request**  

---
