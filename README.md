# Advanced Image Classification and Recognition System 📺🤖
*Lee la versión en Español a continuación: [Versión en Español](#-sistema-avanzado-de-clasificación-y-reconocimiento-de-imágenes)*

## 1. Project Title
**Cartoon Character Classification & SURF-based Recognition System**

**Authors:** Ishak & Ferran Mesa

## 2. General Description
This project tackles a classic Computer Vision problem: visual feature extraction and multi-class classification. The system analyzes images of various cartoon characters (SpongeBob, Gumball, Oliver & Benji, Tom & Jerry, etc.) and classifies them using a Machine Learning model (KNN Ensemble). Additionally, it implements a specific recognition engine using keypoint detection and matching (SURF) to uniquely identify a particular target character against variations in scale, rotation, and background.

## 3. Programming & Software Engineering Competencies
Throughout this project, advanced programming and software structuring competencies have been applied and demonstrated:
- **Modularity & Separation of Concerns (SoC):** The codebase is rigorously divided into dedicated scripts for feature extraction (`buildDescriptorTable.m`), training (`trainClassifier.m`), evaluation (`test.m`), and inference (`main.m`).
- **Data Structures & Memory Management:** Efficient use of multidimensional arrays for image processing, dynamic tables for structured dataset storage (`descriptorTable.mat`), and highly optimized vectorized mathematical operations.
- **Complex Algorithm Implementation:** Manual development of Local Binary Patterns (LBP) descriptors, stroke-width calculation through morphological transformations (Black-Hat), and the design of multidimensional histograms (HSV Color, Sobel Gradients).
- **Machine Learning & Evaluation:** Implementation of complete Data Science workflows, including K-Fold cross-validation, model evaluation metrics (Recall, Accuracy), and confusion matrices.

## 4. Architecture and File Structure
The workspace is conceptually divided between the final project source code (`Delivery`) and previous coursework assignments (`Entregas`).

```text
📦 Computer-Vision
 ┣ 📂 Delivery                  # 🚀 Core source code for the final project
 ┃ ┣ 📂 Check / TRAIN           # Data directories (testing and training images)
 ┃ ┣ 📜 main.m                  # Main entry point for inference
 ┃ ┣ 📜 buildDescriptorTable.m  # Feature extraction pipeline (LBP, HSV, Stroke-Width)
 ┃ ┣ 📜 predictImageClass.m     # Inference script for new unseen images
 ┃ ┣ 📜 isSpongeBob.m           # Advanced vision algorithm (SURF keypoints) for recognition
 ┃ ┣ 📜 train.m / test.m        # Scripts for model training and accuracy evaluation
 ┃ ┣ 📜 trainClassifier.m       # Machine Learning model logic (Subspace KNN Ensemble)
 ┃ ┣ 📜 SPONGE_BOB*.mat/.jpg    # Reference files (ROI and image) for SURF matching
 ┃ ┗ 📜 *.mat                   # Serialized datasets and models (pre-trained weights)
 ┗ 📂 Entregas                  # 📚 History of previous assignment scripts (E1.m - E21.m)
```
*Note: The `Entregas` folder contains independent learning scripts and unit tests developed throughout the course, demonstrating the technical evolution and understanding of individual image processing concepts.*

## 5. Technologies and Tools
- **Language:** MATLAB
- **Toolboxes & Libraries:** 
  - *Image Processing Toolbox* (Morphological operations, filters, LBP, color manipulation).
  - *Computer Vision Toolbox* (SURF feature detection, keypoint matching).
  - *Statistics and Machine Learning Toolbox* (Ensemble model training, KNN, cross-validation).
- **Paradigm:** Imperative and Vectorized Programming oriented to Scientific Computing.

## 6. Requirements and Installation
To compile and run this project locally:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/tu-usuario/Computer-Vision.git
   cd Computer-Vision/Delivery
   ```
2. **Environment Requirements:**
   Ensure you have MATLAB installed (preferably R2024b or higher) along with the toolboxes mentioned in the previous section.
3. **Running the Inference Pipeline:**
   Open the MATLAB command terminal or IDE, navigate to the `Delivery` directory, and execute:
   ```matlab
   % To predict and detect a new image
   main('path/to/your/test_image.jpg')
   ```
4. **Model Retraining (Optional):**
   ```matlab
   buildDescriptorTable('./TRAIN'); % Generates descriptorTable.mat
   run train.m                      % Trains and saves trainedClassifier.mat
   run test.m                       % Evaluates performance on the test set
   ```

## 7. Main Features
- **Multi-class Classification:** Ability to identify multiple classes of cartoon characters through color (HSV Histograms), texture (LBP), and geometric (Stroke-width) feature extraction.
- **Invariant Geometric Recognition:** Detection of specific instances using the SURF algorithm, robust against scale changes, partial occlusion, and rotation.
- **Automated Data Pipeline:** Automated feature table generation by traversing the directory structure of the dataset.
- **Exhaustive Evaluation:** Generation of normalized confusion matrices and calculation of macro-averaged Recall to thoroughly analyze the performance of the KNN Ensemble classifier.

---
<a name="-sistema-avanzado-de-clasificación-y-reconocimiento-de-imágenes"></a>
# Sistema Avanzado de Clasificación y Reconocimiento de Imágenes 📺🤖

## 1. Título del Proyecto
**Sistema de Clasificación de Personajes Animados y Reconocimiento Específico Basado en SURF**

**Autores:** Ishak y Ferran Mesa

## 2. Descripción General
Este proyecto aborda un problema clásico de Visión por Computador: la extracción de características visuales y la clasificación multiclase. El sistema es capaz de analizar imágenes de distintos personajes animados (Bob Esponja, Gumball, Oliver y Benji, Tom y Jerry, etc.) y clasificarlos utilizando un modelo de Machine Learning (Ensemble de KNN). Adicionalmente, implementa un motor de reconocimiento específico que utiliza la detección y emparejamiento de puntos clave (SURF) para identificar de forma unívoca a un personaje en particular frente a variaciones de escala, rotación o fondo.

## 3. Objetivos y Competencias de Programación (Ingeniería de Software & Algoritmia)
A lo largo de este proyecto, se han aplicado y demostrado competencias avanzadas de programación y estructuración de software:
- **Modularidad y Separación de Responsabilidades (SoC):** El código está rigurosamente dividido en scripts dedicados a la extracción de características (`buildDescriptorTable.m`), entrenamiento (`trainClassifier.m`), evaluación (`test.m`) e inferencia (`main.m`).
- **Estructuras de Datos y Manejo de Memoria:** Uso eficiente de matrices multidimensionales para el procesamiento de imágenes, tablas dinámicas para el almacenamiento estructurado de *datasets* (`descriptorTable.mat`) y optimización en la vectorización de operaciones matemáticas.
- **Implementación de Algoritmos Complejos:** Desarrollo manual de descriptores Local Binary Patterns (LBP), cálculo de grosor de trazos mediante transformaciones morfológicas (*Black-Hat*), y diseño de histogramas multidimensionales (Color HSV, Gradientes de Sobel).
- **Machine Learning & Evaluación:** Implementación de flujos completos de *Data Science* que incluyen validación cruzada (K-Fold), métricas de evaluación de modelos (Recall, Accuracy) y matrices de confusión.

## 4. Arquitectura y Estructura de Archivos
El espacio de trabajo se divide conceptualmente entre el código final del proyecto (`Delivery`) y prácticas anteriores (`Entregas`).

```text
📦 Computer-Vision
 ┣ 📂 Delivery                  # 🚀 Código fuente principal del proyecto final
 ┃ ┣ 📂 Check / TRAIN           # Directorios de datos (imágenes de prueba y entrenamiento)
 ┃ ┣ 📜 main.m                  # Punto de entrada principal para inferencia
 ┃ ┣ 📜 buildDescriptorTable.m  # Pipeline de extracción de características (LBP, HSV, Stroke-Width)
 ┃ ┣ 📜 predictImageClass.m     # Script de inferencia para nuevas imágenes
 ┃ ┣ 📜 isSpongeBob.m           # Algoritmo de visión avanzada (SURF keypoints) para reconocimiento
 ┃ ┣ 📜 train.m / test.m        # Scripts para entrenar el modelo y evaluar su precisión
 ┃ ┣ 📜 trainClassifier.m       # Lógica del modelo Machine Learning (Subspace KNN Ensemble)
 ┃ ┣ 📜 SPONGE_BOB*.mat/.jpg    # Archivos de referencia (ROI e imagen) para el emparejamiento SURF
 ┃ ┗ 📜 *.mat                   # Datasets y modelos serializados (pesos pre-entrenados)
 ┗ 📂 Entregas                  # 📚 Historial de scripts de asignaciones previas (E1.m - E21.m)
```
*Nota: La carpeta `Entregas` contiene scripts independientes de aprendizaje y pruebas unitarias desarrolladas durante el transcurso del proyecto, que demuestran la evolución técnica y comprensión de conceptos individuales de procesamiento de imagen.*

## 5. Tecnologías y Herramientas
- **Lenguaje:** MATLAB
- **Toolboxes y Librerías:** 
  - *Image Processing Toolbox* (Operaciones morfológicas, filtros, LBP, manipulación de color).
  - *Computer Vision Toolbox* (Detección de características SURF, emparejamiento de puntos clave).
  - *Statistics and Machine Learning Toolbox* (Entrenamiento de modelos Ensemble, KNN, validación cruzada).
- **Paradigma:** Programación Imperativa y Vectorizada orientada a Cálculo Científico.

## 6. Requisitos e Instalación
Para compilar y ejecutar este proyecto localmente:

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/Computer-Vision.git
   cd Computer-Vision/Delivery
   ```
2. **Requisitos de Entorno:**
   Asegúrate de tener instalado MATLAB (preferiblemente R2024b o superior) junto con los toolboxes mencionados en la sección anterior.
3. **Ejecución del pipeline de inferencia:**
   Abre la terminal de comandos de MATLAB o el IDE, asegúrate de estar en el directorio `Delivery` y ejecuta:
   ```matlab
   % Para predecir y detectar en una imagen nueva
   main('ruta/a/tu/imagen_de_prueba.jpg')
   ```
4. **Reentrenamiento del modelo (Opcional):**
   ```matlab
   buildDescriptorTable('./TRAIN'); % Genera descriptorTable.mat
   run train.m                      % Entrena y guarda trainedClassifier.mat
   run test.m                       % Evalúa el rendimiento en el conjunto de prueba
   ```

## 7. Características Principales (Features)
- **Clasificación Multiclase:** Capacidad para identificar entre múltiples clases de personajes animados mediante extracción de características de color (Histogramas HSV), textura (LBP) y geometría (Stroke-width).
- **Reconocimiento Geométrico Invariante:** Detección de instancias específicas usando el algoritmo SURF, robusto a cambios de escala, oclusión parcial y rotación.
- **Pipeline de Datos Automatizado:** Generación de tablas de características de forma automatizada recorriendo la estructura de directorios del *dataset*.
- **Evaluación Exhaustiva:** Generación de matrices de confusión normalizadas y cálculo de Recall macro-promediado para analizar en profundidad el rendimiento del clasificador KNN Ensemble.
