@extends('layouts.app')

@section('title', 'Cuadrantes - Amigate')
@section('page-title', 'Gestión de Cuadrantes')

@push('styles')
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<style>
    .map-container {
        position: relative;
        width: 100%;
        height: 70vh;
        min-height: 600px;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        background: #f8f9fa;
    }
    
    #map {
        width: 100%;
        height: 100%;
        z-index: 1;
    }
    
    .map-controls {
        position: absolute;
        top: 15px;
        right: 15px;
        z-index: 1000;
        background: white;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        min-width: 200px;
    }
    
    .map-controls h6 {
        font-size: 0.9rem;
        font-weight: 700;
        margin-bottom: 10px;
        color: #1e293b;
    }
    
    .map-controls .form-label {
        font-size: 0.85rem;
        font-weight: 600;
        color: #64748b;
        margin-bottom: 5px;
    }
    
    .map-controls .form-control,
    .map-controls .form-select {
        font-size: 0.9rem;
        padding: 8px 12px;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        transition: border-color 0.2s ease;
    }
    
    .map-controls .form-control:focus,
    .map-controls .form-select:focus {
        border-color: #2563eb;
        outline: none;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }
    
    .controls-sidebar {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        height: 100%;
    }
    
    .control-group {
        margin-bottom: 20px;
    }
    
    .control-group label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #1e293b;
        font-size: 0.9rem;
    }
    
    .control-group input,
    .control-group select {
        width: 100%;
        padding: 12px;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-size: 0.95rem;
        transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }
    
    .control-group input:focus,
    .control-group select:focus {
        outline: none;
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }
    
    .btn-cuadrante {
        width: 100%;
        padding: 12px 20px;
        border: none;
        border-radius: 10px;
        font-size: 0.95rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }
    
    .btn-cuadrante:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    .btn-cuadrante:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none !important;
    }
    
    .btn-reload {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
    }
    
    .btn-reload:hover {
        background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
    }
    
    .btn-primary-cuadrante {
        background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
        color: white;
    }
    
    .btn-primary-cuadrante:hover {
        background: linear-gradient(135deg, #1d4ed8 0%, #1e3a8a 100%);
    }
    
    .btn-success-cuadrante {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
    }
    
    .btn-success-cuadrante:hover {
        background: linear-gradient(135deg, #059669 0%, #047857 100%);
    }
    
    .stats-box {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        border-radius: 12px;
        padding: 20px;
        margin-top: 20px;
        border: 2px solid #e2e8f0;
    }
    
    .stats-box h5 {
        margin-bottom: 15px;
        color: #1e293b;
        font-size: 1.1rem;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .stat-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px solid #e2e8f0;
    }
    
    .stat-item:last-child {
        border-bottom: none;
    }
    
    .stat-label {
        color: #64748b;
        font-weight: 600;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .stat-value {
        color: #2563eb;
        font-weight: 700;
        font-size: 1.3rem;
    }
    
    .loading {
        display: none;
        text-align: center;
        padding: 20px;
        color: #2563eb;
    }
    
    .loading.active {
        display: block;
    }
    
    .spinner {
        border: 3px solid #e2e8f0;
        border-top: 3px solid #2563eb;
        border-radius: 50%;
        width: 35px;
        height: 35px;
        animation: spin 0.8s linear infinite;
        margin: 0 auto 10px;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    .alert-cuadrante {
        padding: 12px 15px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-weight: 500;
        font-size: 0.9rem;
    }
    
    .alert-success {
        background: #d1fae5;
        color: #065f46;
        border: 1px solid #6ee7b7;
    }
    
    .alert-error {
        background: #fee2e2;
        color: #991b1b;
        border: 1px solid #fca5a5;
    }
    
    .alert-info {
        background: #dbeafe;
        color: #1e40af;
        border: 1px solid #93c5fd;
    }
    
    .log {
        background: #f8fafc;
        border-radius: 8px;
        padding: 15px;
        margin-top: 15px;
        max-height: 200px;
        overflow-y: auto;
        font-size: 0.85rem;
        font-family: 'Courier New', monospace;
        border: 1px solid #e2e8f0;
    }
    
    .log-entry {
        padding: 6px 0;
        border-bottom: 1px solid #e2e8f0;
        color: #475569;
    }
    
    .log-entry:last-child {
        border-bottom: none;
    }
    
    /* Estilos para las cuadrículas en el mapa */
    .leaflet-interactive {
        stroke-width: 2.5px;
        stroke-opacity: 0.9;
    }
    
    /* Leyenda de zonas */
    .legend {
        position: absolute;
        bottom: 20px;
        left: 20px;
        z-index: 1000;
        background: white;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        font-size: 0.85rem;
    }
    
    .legend h6 {
        margin-bottom: 10px;
        font-weight: 700;
        color: #1e293b;
    }
    
    .legend-item {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 6px;
    }
    
    .legend-color {
        width: 20px;
        height: 20px;
        border-radius: 4px;
        border: 2px solid rgba(0,0,0,0.2);
    }
    
    /* Responsive */
    @media (max-width: 991.98px) {
        .map-container {
            height: 500px;
            min-height: 500px;
        }
        
        .map-controls {
            position: relative;
            top: 0;
            right: 0;
            margin-bottom: 15px;
            width: 100%;
        }
        
        .controls-sidebar {
            margin-top: 20px;
        }
    }
    
    @media (max-width: 767.98px) {
        .map-container {
            height: 400px;
            min-height: 400px;
        }
        
        .legend {
            bottom: 10px;
            left: 10px;
            padding: 10px;
            font-size: 0.75rem;
        }
        
        .legend-color {
            width: 16px;
            height: 16px;
        }
    }
</style>
@endpush

@section('content')

<div class="row mb-4">
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3">
                            <i class="bi bi-grid-3x3-gap fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Total Cuadrantes</h6>
                        <h3 class="mb-0 fw-bold text-primary" id="statTotalCuadrantes">{{ $cuadrantes->count() }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-success bg-opacity-10 p-3">
                            <i class="bi bi-check-circle fs-4 text-success"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Activos</h6>
                        <h3 class="mb-0 fw-bold text-success">{{ $cuadrantes->where('activo', true)->count() }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-info bg-opacity-10 p-3">
                            <i class="bi bi-file-earmark-text fs-4 text-info"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Total Barrios</h6>
                        <h3 class="mb-0 fw-bold text-info" id="statTotalBarrios">{{ $cuadrantes->sum(function($c) { return is_array($c->barrios) ? count($c->barrios) : 0; }) }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-warning bg-opacity-10 p-3">
                            <i class="bi bi-people fs-4 text-warning"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Total Grupos</h6>
                        <h3 class="mb-0 fw-bold text-warning" id="statTotalGrupos">{{ $grupos ?? 0 }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row g-4">
    
    <div class="col-xl-8 col-lg-12">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white border-0 py-3">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-geo-alt text-primary me-2"></i>
                            Mapa de Cuadrantes
                        </h5>
                        <p class="text-muted small mb-0 mt-1">Visualización de cuadrantes en Santa Cruz de la Sierra</p>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="map-container">
                    <div id="map"></div>
                    
                    
                    <div class="map-controls d-none d-md-block">
                        <h6><i class="bi bi-sliders"></i> Controles Rápidos</h6>
                        <div class="mb-2">
                            <label class="form-label">Tamaño (km)</label>
                            <input type="number" id="gridSizeQuick" class="form-control form-control-sm" value="2" min="0.5" max="10" step="0.5">
                        </div>
                        <button class="btn btn-primary btn-sm w-100" onclick="generarCuadrantes()">
                            <i class="bi bi-grid-3x3"></i> Generar
                        </button>
                    </div>
                    
                    
                    <div class="legend">
                        <h6><i class="bi bi-info-circle"></i> Zonas</h6>
                        <div class="legend-item">
                            <div class="legend-color" style="background-color: #FF6B6B;"></div>
                            <span>Norte</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background-color: #4ECDC4;"></div>
                            <span>Noreste</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background-color: #45B7D1;"></div>
                            <span>Este</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background-color: #96CEB4;"></div>
                            <span>Sur</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color" style="background-color: #FFEAA7;"></div>
                            <span>Centro</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
    <div class="col-xl-4 col-lg-12">
        <div class="controls-sidebar">
            <h5 class="mb-4 fw-bold">
                <i class="bi bi-gear text-primary me-2"></i>
                Panel de Control
            </h5>
            
            <div class="control-group">
                <label><i class="bi bi-rulers me-2"></i>Tamaño de Cuadrante (km)</label>
                <input type="number" id="gridSize" class="form-control" value="2" min="0.5" max="10" step="0.5">
            </div>

            <div class="control-group">
                <label><i class="bi bi-geo-alt me-2"></i>Ciudad</label>
                <input type="text" id="ciudad" class="form-control" value="Santa Cruz de la Sierra" readonly>
            </div>


            <button class="btn-cuadrante btn-reload" onclick="cargarCuadrantesExistentes()">
                <i class="bi bi-arrow-clockwise"></i>
                Recargar desde BD
            </button>

            <button class="btn-cuadrante btn-primary-cuadrante" onclick="generarCuadrantes()">
                <i class="bi bi-grid-3x3"></i>
                Generar Cuadrantes Nuevos
            </button>

            <button class="btn-cuadrante btn-success-cuadrante" id="guardarBtn" onclick="guardarEnBaseDatos()" disabled>
                <i class="bi bi-save"></i>
                Guardar en Base de Datos
            </button>

            <div class="loading" id="loading">
                <div class="spinner"></div>
                <p class="mb-0">Procesando...</p>
            </div>

            <div id="alertContainer"></div>

            <div class="stats-box">
                <h5>
                    <i class="bi bi-bar-chart-fill text-primary"></i>
                    Estadísticas
                </h5>
                <div class="stat-item">
                    <span class="stat-label">
                        <i class="bi bi-grid-3x3-gap text-primary"></i>
                        Cuadrantes:
                    </span>
                    <span class="stat-value" id="statCuadrantes">0</span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">
                        <i class="bi bi-house-door text-success"></i>
                        Barrios:
                    </span>
                    <span class="stat-value" id="statBarrios">0</span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">
                        <i class="bi bi-people text-warning"></i>
                        Grupos:
                    </span>
                    <span class="stat-value" id="statGrupos">0</span>
                </div>
            </div>

            <div class="log" id="log"></div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
    let map;
    let cuadrantesGenerados = [];
    let rectangles = [];
// Datos de cuadrantes desde PHP (Base de Datos)
const cuadrantesData = {!! json_encode($cuadrantes->map(function($c) {
    $barrios = $c->barrios;
    if (is_string($barrios)) {
        $barrios = json_decode($barrios, true) ?? [];
    }
    if (!is_array($barrios)) {
        $barrios = [];
    }
    
    return [
        'id' => $c->id,
        'codigo' => $c->codigo,
        'fila' => $c->fila,
        'columna' => $c->columna,
        'nombre' => $c->nombre,
        'lat_min' => (float)$c->lat_min,
        'lat_max' => (float)$c->lat_max,
        'lng_min' => (float)$c->lng_min,
        'lng_max' => (float)$c->lng_max,
        'centro_lat' => (float)(($c->lat_min + $c->lat_max) / 2),
        'centro_lng' => (float)(($c->lng_min + $c->lng_max) / 2),
        'ciudad' => $c->ciudad,
        'zona' => $c->zona,
        'activo' => $c->activo,
        'barrios' => $barrios
    ];
})->values()->all()) !!};

const totalGrupos = {{ $grupos ?? 0 }};

console.log('Cuadrantes cargados:', cuadrantesData.length);

// Límites de Santa Cruz de la Sierra
const santaCruzBounds = {
    norte: -17.7000,
    sur: -17.8500,
    este: -63.1000,
    oeste: -63.2500
};
    // Inicializar mapa
    function initMap() {
        map = L.map('map').setView([-17.7833, -63.1821], 12);
        
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Dibujar límites de Santa Cruz
        const bounds = [[santaCruzBounds.norte, santaCruzBounds.oeste], 
                      [santaCruzBounds.sur, santaCruzBounds.este]];
        L.rectangle(bounds, {
            color: '#2563eb',
            weight: 3,
            fillOpacity: 0.1
        }).addTo(map);

        addLog('✅ Mapa inicializado correctamente');
        
        // Sincronizar controles rápidos
        const gridSizeInput = document.getElementById('gridSize');
        const gridSizeQuick = document.getElementById('gridSizeQuick');
        if (gridSizeInput && gridSizeQuick) {
            gridSizeInput.addEventListener('input', function() {
                gridSizeQuick.value = this.value;
            });
            gridSizeQuick.addEventListener('input', function() {
                gridSizeInput.value = this.value;
            });
        }
    }

    // Cargar cuadrantes existentes de la base de datos (desde PHP)
    function cargarCuadrantesExistentes() {
        try {
            addLog('🔄 Cargando cuadrantes existentes...');
            document.getElementById('loading').classList.add('active');
            
            // Limpiar cuadrantes anteriores
            rectangles.forEach(rect => map.removeLayer(rect));
            rectangles = [];
            
            if (cuadrantesData.length === 0) {
                addLog('ℹ️ No hay cuadrantes en la base de datos');
                showAlert('info', 'No hay cuadrantes guardados. Genera nuevos cuadrantes.');
                document.getElementById('loading').classList.remove('active');
                return;
            }

            let totalBarrios = 0;

            // Dibujar cada cuadrante en el mapa
            for (const cuadrante of cuadrantesData) {
                const bounds = [
                    [cuadrante.lat_min, cuadrante.lng_min],
                    [cuadrante.lat_max, cuadrante.lng_max]
                ];
                
                const zona = cuadrante.zona || determinarZona(cuadrante.centro_lat, cuadrante.centro_lng);
                
                const rect = L.rectangle(bounds, {
                    color: getColorPorZona(zona),
                    weight: 2.5,
                    fillOpacity: 0.3
                }).addTo(map);

                // Obtener barrios del cuadrante (desde el array barrios)
                const barrios = Array.isArray(cuadrante.barrios) ? cuadrante.barrios : [];
                totalBarrios += barrios.length;

                const barriosTexto = barrios.length > 0 
                    ? barrios.join('<br>') 
                    : 'Sin barrios';

                rect.bindPopup(`
                    <div style="min-width: 200px;">
                        <h6 style="margin-bottom: 10px; color: #2563eb;">
                            <i class="bi bi-geo-alt-fill"></i> ${cuadrante.nombre}
                        </h6>
                        <p style="margin: 5px 0;">
                            <strong>Código:</strong> ${cuadrante.codigo}<br>
                            <strong>Zona:</strong> ${zona}<br>
                            <strong>Ciudad:</strong> ${cuadrante.ciudad}<br>
                            <strong>Barrios:</strong> ${barrios.length}
                        </p>
                        <hr style="margin: 10px 0; border-color: #e2e8f0;">
                        <div style="max-height: 150px; overflow-y: auto;">
                            <small>${barriosTexto}</small>
                        </div>
                    </div>
                `);

                rectangles.push(rect);
            }

            // Actualizar estadísticas
            document.getElementById('statCuadrantes').textContent = cuadrantesData.length;
            document.getElementById('statBarrios').textContent = totalBarrios;
            document.getElementById('statTotalCuadrantes').textContent = cuadrantesData.length;
            document.getElementById('statTotalBarrios').textContent = totalBarrios;
            document.getElementById('statGrupos').textContent = totalGrupos;
            document.getElementById('statTotalGrupos').textContent = totalGrupos;

            // Ajustar el mapa para que se vean todos los cuadrantes
            if (rectangles.length > 0) {
                const group = L.featureGroup(rectangles);
                map.fitBounds(group.getBounds().pad(0.1));
            }

            addLog(`✅ ${cuadrantesData.length} cuadrantes cargados desde la base de datos`);
            showAlert('success', `Se cargaron ${cuadrantesData.length} cuadrantes existentes`);
            
        } catch (error) {
            console.error('Error:', error);
            addLog(`❌ Error al cargar cuadrantes: ${error.message}`);
            showAlert('error', 'Error al cargar los cuadrantes desde la base de datos.');
        } finally {
            document.getElementById('loading').classList.remove('active');
        }
    }

    // Generar cuadrantes
    function generarCuadrantes() {
        const gridSize = parseFloat(document.getElementById('gridSize').value);
        
        // Limpiar cuadrantes anteriores
        rectangles.forEach(rect => map.removeLayer(rect));
        rectangles = [];
        cuadrantesGenerados = [];

        const latDiff = 0.009 * gridSize; // Aproximadamente 1 km
        const lngDiff = 0.011 * gridSize;

        let filaIndex = 0;
        let columnaIndex = 0;
        let totalBarrios = 0;

        addLog('🔄 Generando cuadrantes...');

        for (let lat = santaCruzBounds.norte; lat > santaCruzBounds.sur; lat -= latDiff) {
            columnaIndex = 0;
            const fila = String.fromCharCode(65 + filaIndex); // A, B, C...

            for (let lng = santaCruzBounds.oeste; lng < santaCruzBounds.este; lng += lngDiff) {
                const latMin = lat - latDiff;
                const latMax = lat;
                const lngMin = lng;
                const lngMax = lng + lngDiff;
                const centroLat = (latMin + latMax) / 2;
                const centroLng = (lngMin + lngMax) / 2;

                const codigo = `${fila}${columnaIndex + 1}`;
                const nombre = `Cuadrante ${codigo}`;

                // Generar barrios aleatorios para este cuadrante (2-5 barrios)
                const numBarrios = Math.floor(Math.random() * 4) + 2;
                const barriosAleatorios = [];
                const nombresBarrios = [
                    'Centro', 'Norte', 'Sur', 'Este', 'Oeste', 'Villa', 'Urbanización',
                    'Plan 3000', 'Equipetrol', 'Las Palmas', 'Urbarí', 'Hamacas',
                    'Cristo Redentor', 'Palmasola', 'Satélite Norte', 'Los Pozos'
                ];

                for (let i = 0; i < numBarrios; i++) {
                    const nombreBarrio = nombresBarrios[Math.floor(Math.random() * nombresBarrios.length)] + ' ' + codigo;
                    barriosAleatorios.push(nombreBarrio);
                }

                totalBarrios += numBarrios;

                const cuadrante = {
                    codigo: codigo,
                    fila: fila,
                    columna: columnaIndex + 1,
                    nombre: nombre,
                    lat_min: latMin,
                    lat_max: latMax,
                    lng_min: lngMin,
                    lng_max: lngMax,
                    centro_lat: centroLat,
                    centro_lng: centroLng,
                    ciudad: 'Santa Cruz de la Sierra',
                    zona: determinarZona(centroLat, centroLng),
                    activo: true,
                    barrios: barriosAleatorios
                };

                cuadrantesGenerados.push(cuadrante);

                // Dibujar rectángulo en el mapa
                const bounds = [[latMin, lngMin], [latMax, lngMax]];
                const rect = L.rectangle(bounds, {
                    color: getColorPorZona(cuadrante.zona),
                    weight: 2.5,
                    fillOpacity: 0.2
                }).addTo(map);

                rect.bindPopup(`
                    <b>${nombre}</b><br>
                    Código: ${codigo}<br>
                    Zona: ${cuadrante.zona}<br>
                    Barrios: ${numBarrios}
                `);

                rectangles.push(rect);
                columnaIndex++;
            }
            filaIndex++;
        }

        // Actualizar estadísticas
        document.getElementById('statCuadrantes').textContent = cuadrantesGenerados.length;
        document.getElementById('statBarrios').textContent = totalBarrios;
        document.getElementById('statGrupos').textContent = cuadrantesGenerados.length;
        document.getElementById('statTotalCuadrantes').textContent = cuadrantesGenerados.length;
        document.getElementById('statTotalBarrios').textContent = totalBarrios;
        document.getElementById('statTotalGrupos').textContent = cuadrantesGenerados.length;
        document.getElementById('guardarBtn').disabled = false;

        addLog(`✅ ${cuadrantesGenerados.length} cuadrantes generados`);
        addLog(`✅ ${totalBarrios} barrios generados`);
        showAlert('success', `Se generaron ${cuadrantesGenerados.length} cuadrantes y ${totalBarrios} barrios`);
    }

    // Determinar zona según coordenadas
    function determinarZona(lat, lng) {
        const centroLat = -17.7833;
        const centroLng = -63.1821;

        if (lat > centroLat && lng < centroLng) return 'Norte';
        if (lat > centroLat && lng > centroLng) return 'Noreste';
        if (lat < centroLat && lng > centroLng) return 'Este';
        if (lat < centroLat && lng < centroLng) return 'Sur';
        return 'Centro';
    }

    // Color por zona
    function getColorPorZona(zona) {
        const colores = {
            'Norte': '#FF6B6B',
            'Noreste': '#4ECDC4',
            'Este': '#45B7D1',
            'Sur': '#96CEB4',
            'Centro': '#FFEAA7'
        };
        return colores[zona] || '#95A5A6';
    }

    // Guardar en base de datos
    async function guardarEnBaseDatos() {
        const apiEndpoint = document.getElementById('apiEndpoint').value;
        document.getElementById('loading').classList.add('active');
        document.getElementById('guardarBtn').disabled = true;

        let cuadrantesCreados = 0;
        let barriosCreados = 0;
        let gruposCreados = 0;

        addLog('🔄 Iniciando guardado en base de datos...');

        for (const cuadrante of cuadrantesGenerados) {
            try {
                // 1. Crear cuadrante usando ruta Laravel
                const resCuadrante = await fetch('{{ route("cuadrantes.store") }}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                        'X-CSRF-TOKEN': '{{ csrf_token() }}'
                    },
                    body: JSON.stringify({
                        codigo: cuadrante.codigo,
                        fila: cuadrante.fila,
                        columna: cuadrante.columna,
                        nombre: cuadrante.nombre,
                        lat_min: cuadrante.lat_min,
                        lat_max: cuadrante.lat_max,
                        lng_min: cuadrante.lng_min,
                        lng_max: cuadrante.lng_max,
                        ciudad: cuadrante.ciudad,
                        zona: cuadrante.zona,
                        activo: cuadrante.activo,
                        barrios: cuadrante.barrios
                    })
                });

                if (!resCuadrante.ok) {
                    const error = await resCuadrante.json();
                    throw new Error(JSON.stringify(error));
                }

                const cuadranteData = await resCuadrante.json();
                cuadrantesCreados++;
                addLog(`✅ Cuadrante ${cuadrante.codigo} creado`);

                // Los barrios se guardan en el campo barrios del cuadrante (array)
                if (Array.isArray(cuadrante.barrios)) {
                    barriosCreados += cuadrante.barrios.length;
                }

                // 3. Crear grupo para el cuadrante usando ruta Laravel
                const resGrupo = await fetch('{{ route("grupos.store") }}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                        'X-CSRF-TOKEN': '{{ csrf_token() }}'
                    },
                    body: JSON.stringify({
                        cuadrante_id: cuadranteData.id,
                        nombre: `Grupo ${cuadrante.nombre}`,
                        descripcion: `Grupo comunitario del ${cuadrante.nombre} - Zona ${cuadrante.zona}`,
                        publico: true,
                        requiere_aprobacion: false
                    })
                });

                if (resGrupo.ok) {
                    gruposCreados++;
                    addLog(`✅ Grupo para ${cuadrante.codigo} creado`);
                }

            } catch (error) {
                console.error('Error:', error);
                addLog(`❌ Error en ${cuadrante.codigo}: ${error.message}`);
            }
        }

        document.getElementById('loading').classList.remove('active');
        document.getElementById('statCuadrantes').textContent = cuadrantesCreados;
        document.getElementById('statBarrios').textContent = barriosCreados;
        document.getElementById('statGrupos').textContent = gruposCreados;
        document.getElementById('statTotalCuadrantes').textContent = cuadrantesCreados;
        document.getElementById('statTotalBarrios').textContent = barriosCreados;
        document.getElementById('statTotalGrupos').textContent = gruposCreados;

        showAlert('success', `✅ Guardado completado: ${cuadrantesCreados} cuadrantes, ${barriosCreados} barrios, ${gruposCreados} grupos`);
        addLog('✅ Proceso completado exitosamente');
    }

    // Mostrar alerta
    function showAlert(type, message) {
        const container = document.getElementById('alertContainer');
        const alert = document.createElement('div');
        alert.className = `alert-cuadrante alert-${type}`;
        alert.textContent = message;
        container.innerHTML = '';
        container.appendChild(alert);

        setTimeout(() => {
            alert.remove();
        }, 5000);
    }

    // Agregar entrada al log
    function addLog(message) {
        const log = document.getElementById('log');
        const entry = document.createElement('div');
        entry.className = 'log-entry';
        const timestamp = new Date().toLocaleTimeString();
        entry.textContent = `[${timestamp}] ${message}`;
        log.insertBefore(entry, log.firstChild);
    }

    // Inicializar al cargar
    window.onload = function() {
        initMap();
        // Cargar cuadrantes existentes automáticamente
        cargarCuadrantesExistentes();
    };
</script>
@endpush
