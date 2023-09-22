-- Crear tabla de Instrumentos Musicales
CREATE TABLE IF NOT EXISTS Instrumentos (
    ID_Instrumento INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT
);

-- Crear tabla de Espectros de Frecuencia
CREATE TABLE IF NOT EXISTS Espectros (
    ID_Espectro INTEGER PRIMARY KEY AUTOINCREMENT,
    F0 REAL,
    F1 REAL,
    F2 REAL,
    F3 REAL,
    IDEvaluacionMachineLearning INTEGER REFERENCES EvaluacionesMachineLearning (IDEvaluacionMachineLearning)
);

-- Crear tabla de Categorías Machine Learning
CREATE TABLE IF NOT EXISTS CategoriasMachineLearning (
    ID_Categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT
);

-- Crear tabla de Archivos Maestros de Audio con URLPatch
CREATE TABLE IF NOT EXISTS ArchivosMaestros (
    ID_Archivo INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT,
    Duracion REAL,
    URLPatch TEXT,
    ID_Instrumento INTEGER REFERENCES Instrumentos (ID_Instrumento)
);

-- Crear tabla de Archivos de Marcadores de Tiempo con URLPatch
CREATE TABLE IF NOT EXISTS ArchivoMarcadoresTiempo (
    ID_ArchivoMarcadores INTEGER PRIMARY KEY AUTOINCREMENT,
    URLPatch TEXT,
    ID_ArchivoMaestro INTEGER REFERENCES ArchivosMaestros (ID_Archivo)
);

-- Crear tabla de Data en Archivo de Marcadores de Tiempo con TiempoInicio y TiempoFinal
CREATE TABLE IF NOT EXISTS DataArchivoMarcadoresTiempo (
    ID_Data INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_ArchivoMarcadores INTEGER REFERENCES ArchivoMarcadoresTiempo (ID_ArchivoMarcadores),
    TiempoInicio REAL,
    TiempoFinal REAL,
    Label TEXT
);

-- Crear tabla de Tipos de Notas MIDI
CREATE TABLE IF NOT EXISTS TiposNotasMIDI (
    ID_TipoNota INTEGER PRIMARY KEY AUTOINCREMENT,
    NombreNota TEXT
);

-- Crear tabla de Pitch
CREATE TABLE IF NOT EXISTS Pitch (
    ID_Pitch INTEGER PRIMARY KEY AUTOINCREMENT,
    Valor REAL,
    ID_Espectro INTEGER REFERENCES Espectros (ID_Espectro),
    IDEvaluacionTonal INTEGER REFERENCES EvaluacionesTonal (IDEvaluacionTonal)
);

-- Crear tabla de Muestras de Audio con Nota Musical
CREATE TABLE IF NOT EXISTS MuestrasAudio (
    ID_Muestra INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT,
    Fecha DATE,
    ID_Instrumento INTEGER REFERENCES Instrumentos (ID_Instrumento),
    ID_TipoNota INTEGER REFERENCES TiposNotasMIDI (ID_TipoNota)
);

-- Cambiar el nombre de la tabla Evaluaciones a EvaluacionesMachineLearning
CREATE TABLE IF NOT EXISTS EvaluacionesMachineLearning (
    IDEvaluacionMachineLearning INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT,
    Fecha DATE,
    ID_CategoriaMachineLearning INTEGER REFERENCES CategoriasMachineLearning (ID_Categoria)
);

-- Cambiar las referencias a Evaluaciones por EvaluacionesMachineLearning en DataEvaluaciones
CREATE TABLE IF NOT EXISTS DataEvaluaciones (
    ID_DataEvaluacion INTEGER PRIMARY KEY AUTOINCREMENT,
    IDEvaluacionMachineLearning INTEGER REFERENCES EvaluacionesMachineLearning (IDEvaluacionMachineLearning),
    Probabilidad REAL
);

-- Crear tabla de TipoEvaluacionTonal
CREATE TABLE IF NOT EXISTS TipoEvaluacionTonal (
    IDTipoEvaluacionTonal INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT
);

-- Crear tabla de EvaluacionesTonal
CREATE TABLE IF NOT EXISTS EvaluacionesTonal (
    IDEvaluacionTonal INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT,
    Fecha DATE,
    IDMuestraAudio INTEGER REFERENCES MuestrasAudio (ID_Muestra),
    IDTipoEvaluacionTonal INTEGER REFERENCES TipoEvaluacionTonal (IDTipoEvaluacionTonal)
);



