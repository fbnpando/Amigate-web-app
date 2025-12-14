@extends('layouts.app')

@section('title', 'Dashboard - Amigate')
@section('page-title', 'Dashboard')

@push('styles')
<style>
    .dashboard-header {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        border-radius: 20px;
        padding: 30px;
        color: white;
        margin-bottom: 30px;
        position: relative;
        overflow: hidden;
    }
    
    .dashboard-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        border-radius: 50%;
    }
    
    .dashboard-header h1 {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 10px;
        position: relative;
        z-index: 1;
    }
    
    .dashboard-header p {
        font-size: 1.1rem;
        opacity: 0.95;
        position: relative;
        z-index: 1;
    }
    
    .stat-card {
        background: white;
        border-radius: 20px;
        padding: 25px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        height: 100%;
        border-left: 4px solid;
    }
    
    .stat-card::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(0,0,0,0.03) 0%, transparent 70%);
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    
    .stat-card:hover::before {
        opacity: 1;
    }
    
    .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 6px 25px rgba(0,0,0,0.1);
    }
    
    .stat-card.primary { border-left-color: #2563eb; }
    .stat-card.success { border-left-color: #10b981; }
    .stat-card.warning { border-left-color: #f59e0b; }
    .stat-card.info { border-left-color: #06b6d4; }
    .stat-card.danger { border-left-color: #ef4444; }
    
    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        margin-bottom: 15px;
    }
    
    .stat-icon.primary { background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%); color: white; }
    .stat-icon.success { background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white; }
    .stat-icon.warning { background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: white; }
    .stat-icon.info { background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%); color: white; }
    .stat-icon.danger { background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%); color: white; }
    
    .stat-value {
        font-size: 2.5rem;
        font-weight: 700;
        margin: 10px 0;
        background: linear-gradient(135deg, #1e293b 0%, #475569 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    .stat-label {
        font-size: 0.9rem;
        color: #64748b;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .stat-change {
        font-size: 0.85rem;
        margin-top: 8px;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .mini-stat-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        text-align: center;
        box-shadow: 0 2px 15px rgba(0,0,0,0.06);
        transition: all 0.3s ease;
        border-top: 3px solid;
    }
    
    .mini-stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    
    .mini-stat-card.danger { border-top-color: #ef4444; }
    .mini-stat-card.success { border-top-color: #10b981; }
    .mini-stat-card.warning { border-top-color: #f59e0b; }
    .mini-stat-card.info { border-top-color: #06b6d4; }
    
    .chart-container {
        background: white;
        border-radius: 20px;
        padding: 25px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        height: 100%;
    }
    
    .activity-card {
        background: white;
        border-radius: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        overflow: hidden;
    }
    
    .activity-item {
        padding: 20px;
        border-bottom: 1px solid #f1f5f9;
        transition: all 0.2s ease;
    }
    
    .activity-item:hover {
        background: #f8fafc;
        padding-left: 22px;
    }
    
    .activity-item:last-child {
        border-bottom: none;
    }
    
    .user-avatar {
        width: 45px;
        height: 45px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 1.1rem;
    }
    
    .category-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 15px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.2s ease;
    }
    
    .category-badge:hover {
        transform: scale(1.02);
    }
    
    /* Animación de Pulso para Alertas */
    @keyframes pulse-border {
        0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.7); }
        70% { box-shadow: 0 0 0 15px rgba(239, 68, 68, 0); }
        100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
    }
    
    .pulse-animation {
        animation: pulse-border 2s infinite;
    }
    
    .fade-in {
        opacity: 0;
        animation: fadeIn 0.3s ease forwards;
    }
    
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
    
    /* Desactivar animaciones para mejor rendimiento en carga */
    @media (prefers-reduced-motion: reduce) {
        .fade-in {
            animation: none;
            opacity: 1;
        }
    }
    
    /* Optimización: GPU acceleration */
    .stat-card,
    .mini-stat-card,
    .chart-container,
    .activity-card {
        will-change: transform;
        transform: translateZ(0);
    }
    
    /* ============================================
       RESPONSIVE DESIGN
       ============================================ */
    
    /* Tablet y Desktop Pequeño (768px - 991px) */
    @media (max-width: 991.98px) {
        .dashboard-header {
            padding: 25px 20px;
            border-radius: 15px;
        }
        
        .dashboard-header h1 {
            font-size: 2rem;
        }
        
        .dashboard-header p {
            font-size: 1rem;
        }
        
        .stat-card {
            padding: 20px;
            border-radius: 15px;
        }
        
        .stat-value {
            font-size: 2rem;
        }
        
        .stat-icon {
            width: 50px;
            height: 50px;
            font-size: 1.5rem;
        }
        
        .chart-container {
            padding: 20px;
            border-radius: 15px;
        }
        
        .activity-item {
            padding: 15px;
        }
        
        .activity-item:hover {
            padding-left: 20px;
        }
    }
    
    /* Móvil (576px - 767px) */
    @media (max-width: 767.98px) {
        .dashboard-header {
            padding: 20px 15px;
            border-radius: 15px;
            margin-bottom: 20px;
        }
        
        .dashboard-header h1 {
            font-size: 1.75rem;
            margin-bottom: 8px;
        }
        
        .dashboard-header p {
            font-size: 0.9rem;
        }
        
        .dashboard-header .d-flex {
            flex-direction: column;
            align-items: flex-start !important;
            gap: 15px;
        }
        
        .dashboard-header .text-end {
            text-align: left !important;
            width: 100%;
        }
        
        .stat-card {
            padding: 20px 15px;
            border-radius: 12px;
            margin-bottom: 15px;
        }
        
        .stat-icon {
            width: 50px;
            height: 50px;
            font-size: 1.5rem;
            margin-bottom: 12px;
        }
        
        .stat-value {
            font-size: 1.75rem;
            margin: 8px 0;
        }
        
        .stat-label {
            font-size: 0.8rem;
        }
        
        .stat-change {
            font-size: 0.8rem;
            flex-wrap: wrap;
        }
        
        .mini-stat-card {
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 15px;
        }
        
        .mini-stat-card i {
            font-size: 2rem !important;
        }
        
        .mini-stat-card h3 {
            font-size: 1.5rem;
        }
        
        .chart-container {
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
        }
        
        .chart-container h5 {
            font-size: 1rem;
        }
        
        .chart-container p {
            font-size: 0.85rem;
        }
        
        .activity-card {
            border-radius: 15px;
            margin-bottom: 20px;
        }
        
        .activity-card .card-header {
            padding: 15px !important;
        }
        
        .activity-card .card-header h5 {
            font-size: 1rem;
        }
        
        .activity-card .card-header p {
            font-size: 0.8rem;
        }
        
        .activity-item {
            padding: 15px;
            flex-direction: column;
        }
        
        .activity-item:hover {
            padding-left: 15px;
        }
        
        .activity-item .d-flex {
            flex-direction: column;
            align-items: flex-start !important;
        }
        
        .activity-item .flex-grow-1 {
            width: 100%;
        }
        
        .activity-item .d-flex.justify-content-between {
            flex-direction: column;
            gap: 10px;
        }
        
        .activity-item .text-end {
            text-align: left !important;
            width: 100%;
        }
        
        .activity-item .d-flex.align-items-center.gap-2 {
            flex-wrap: wrap;
            gap: 8px !important;
        }
        
        .activity-item .d-flex.align-items-center.gap-3 {
            flex-direction: column;
            align-items: flex-start !important;
            gap: 8px !important;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            font-size: 1rem;
        }
        
        .category-badge {
            padding: 8px 12px;
            font-size: 0.85rem;
            width: 100%;
            justify-content: space-between;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
        }
        
        /* Ajustes de columnas Bootstrap */
        .row.g-4 {
            --bs-gutter-y: 1rem;
            --bs-gutter-x: 1rem;
        }
    }
    
    /* Móvil Pequeño (menos de 576px) */
    @media (max-width: 575.98px) {
        .dashboard-header {
            padding: 15px;
            border-radius: 12px;
        }
        
        .dashboard-header h1 {
            font-size: 1.5rem;
        }
        
        .dashboard-header p {
            font-size: 0.85rem;
        }
        
        .stat-card {
            padding: 15px;
        }
        
        .stat-icon {
            width: 45px;
            height: 45px;
            font-size: 1.3rem;
        }
        
        .stat-value {
            font-size: 1.5rem;
        }
        
        .stat-label {
            font-size: 0.75rem;
        }
        
        .mini-stat-card {
            padding: 12px;
        }
        
        .mini-stat-card i {
            font-size: 1.75rem !important;
        }
        
        .mini-stat-card h3 {
            font-size: 1.25rem;
        }
        
        .chart-container {
            padding: 12px;
        }
        
        .activity-item {
            padding: 12px;
        }
        
        .activity-item h6 {
            font-size: 0.9rem;
        }
        
        .badge {
            font-size: 0.7rem;
            padding: 4px 8px;
        }
        
        /* Ocultar algunos elementos en móvil muy pequeño */
        .dashboard-header .text-end {
            display: none;
        }
    }
    
    /* Ajustes para gráficos responsive */
    @media (max-width: 767.98px) {
        #tipoReportesChart,
        #prioridadChart {
            max-height: 250px !important;
        }
    }
    
    @media (max-width: 575.98px) {
        #tipoReportesChart,
        #prioridadChart {
            max-height: 200px !important;
        }
    }
    
    /* Mejoras de accesibilidad en móvil */
    @media (max-width: 767.98px) {
        .btn {
            min-height: 40px;
            padding: 8px 16px;
        }
        
        .btn-sm {
            min-height: 36px;
        }
        
        /* Asegurar que los textos sean legibles */
        small {
            font-size: 0.8rem;
        }
        
        /* Mejorar espaciado en listas */
        .list-group-item {
            padding: 12px 15px;
        }
    }
</style>
@endpush

@section('content')

<div class="dashboard-header">
    <div class="d-flex justify-content-between align-items-center flex-wrap">
        <div class="flex-grow-1">
            <h1>
                <i class="bi bi-speedometer2 me-2"></i>
                Bienvenido de vuelta
            </h1>
            <p>
                <i class="bi bi-calendar3 me-2"></i>
                {{ now()->format('l, d F Y') }} - {{ now()->format('H:i') }}
            </p>
        </div>
        <div class="text-end d-none d-md-block">
            <div class="d-flex align-items-center gap-3">
                <div class="text-white-50">
                    <i class="bi bi-activity fs-4"></i>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row g-4 mb-4">
    <!-- Card TOTAL USUARIOS (Comunidad) -->
    <div class="col-xl-3 col-md-6">
        <div class="stat-card success">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <div class="stat-label text-success mb-1">COMUNIDAD</div>
                    <div class="stat-value text-dark" style="font-size: 3.5rem;">{{ $totalUsuarios ?? 0 }}</div>
                </div>
                <div class="stat-icon success">
                    <i class="bi bi-people-fill"></i>
                </div>
            </div>
            <div class="stat-change text-success fw-bold">
                <i class="bi bi-arrow-up-circle-fill me-1"></i>
                Usuarios registrados
            </div>
        </div>
    </div>
    
    <!-- Card ZONA CRÍTICA (Donde hay más casos) -->
    <div class="col-xl-3 col-md-6">
        <div class="stat-card info">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <div class="stat-label text-info mb-1">ZONA CRÍTICA</div>
                    <div class="stat-value text-dark" style="font-size: 1.8rem;">
                        {{ $zonaCritica ? Str::limit($zonaCritica->nombre, 12) : 'N/A' }}
                    </div>
                </div>
                <div class="stat-icon info">
                    <i class="bi bi-map-fill"></i>
                </div>
            </div>
            <div class="stat-change text-muted">
                {{ $zonaCritica ? $zonaCritica->reportes_count . ' casos activos' : 'Sin datos' }}
            </div>
        </div>
    </div>
    
    <!-- Card NUEVOS HOY (Flujo diario) -->
    <div class="col-xl-3 col-md-6">
        <div class="stat-card primary">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <div class="stat-label text-primary mb-1">NUEVOS HOY</div>
                    <div class="stat-value text-dark">{{ $reportesHoy }}</div>
                </div>
                <div class="stat-icon primary">
                    <i class="bi bi-calendar-check-fill"></i>
                </div>
            </div>
            <div class="stat-change text-muted">
                Registrados las últimas 24h
            </div>
        </div>
    </div>
    
    <!-- Card TOTAL ACTIVOS (Carga de trabajo) -->
    <div class="col-xl-3 col-md-6">
        <div class="stat-card warning">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <div class="stat-label text-warning mb-1">TOTAL ACTIVOS</div>
                    <div class="stat-value text-dark">{{ number_format($reportesActivos ?? 0, 0, ',', '.') }}</div>
                </div>
                <div class="stat-icon warning">
                    <i class="bi bi-collection-fill"></i>
                </div>
            </div>
            <div class="stat-change text-muted">
                Casos pendientes de resolución
            </div>
        </div>
    </div>
</div>





<div class="row g-4 mb-4">
    <div class="col-xl-6">
        <div class="chart-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="mb-1 fw-bold">
                        <i class="bi bi-pie-chart-fill text-primary me-2"></i>
                        Distribución por Tipo
                    </h5>
                    <p class="text-muted small mb-0">Reportes perdidos vs encontrados</p>
                </div>
            </div>
            <canvas id="tipoReportesChart" style="max-height: 300px;"></canvas>
        </div>
    </div>
    
    <div class="col-xl-6">
        <div class="chart-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="mb-1 fw-bold">
                        <i class="bi bi-tags-fill text-primary me-2"></i>
                        Categorías Más Frecuentes
                    </h5>
                    <p class="text-muted small mb-0">Distribución por tipo de incidencia</p>
                </div>
            </div>
            <canvas id="categoriasChart" style="max-height: 300px;"></canvas>
        </div>
    </div>
</div>

<div class="row g-4">
    <!-- Actividad Reciente (Columna Principal) -->
    <div class="col-12 col-xl-8">
        <div class="activity-card">
            <div class="card-header bg-white border-0 py-4 px-4">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                    <div>
                        <h5 class="mb-1 fw-bold">
                            <i class="bi bi-clock-history text-primary me-2"></i>
                            Actividad Reciente
                        </h5>
                        <p class="text-muted small mb-0">Últimos reportes del sistema</p>
                    </div>
                    <a href="{{ route('reportes.index') }}" class="btn btn-primary btn-sm rounded-pill px-3">
                        Ver todos <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
            <div class="card-body p-0">
                @forelse($ultimosReportes ?? [] as $reporte)
                <div class="activity-item">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0 me-3">
                            <div class="user-avatar bg-primary-subtle text-primary rounded-4">
                                <i class="bi bi-file-earmark-text fs-5"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <h6 class="mb-1 fw-bold text-dark">{{ Str::limit($reporte->titulo, 50) }}</h6>
                                    <div class="d-flex align-items-center gap-2 flex-wrap">
                                        <span class="badge bg-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }}-subtle text-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }} border border-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }} rounded-pill">
                                            <i class="bi bi-{{ $reporte->tipo_reporte == 'perdido' ? 'x-circle' : 'check-circle' }}-fill me-1"></i>
                                            {{ ucfirst($reporte->tipo_reporte) }}
                                        </span>
                                        <span class="badge rounded-pill" style="background-color: {{ $reporte->categoria->color ?? '#6c757d' }}20; color: {{ $reporte->categoria->color ?? '#6c757d' }}; border: 1px solid {{ $reporte->categoria->color ?? '#6c757d' }}">
                                            {{ $reporte->categoria->nombre ?? 'N/A' }}
                                        </span>
                                        @if($reporte->recompensa)
                                            <span class="badge bg-warning-subtle text-warning border border-warning rounded-pill">
                                                <i class="bi bi-cash-coin me-1"></i>Bs. {{ number_format($reporte->recompensa, 2) }}
                                            </span>
                                        @endif
                                    </div>
                                </div>
                                <div class="text-end">
                                    @if($reporte->estado == 'activo')
                                        <span class="badge bg-primary-subtle text-primary border border-primary rounded-pill px-3">Activo</span>
                                    @elseif($reporte->estado == 'resuelto')
                                        <span class="badge bg-success-subtle text-success border border-success rounded-pill px-3">
                                            <i class="bi bi-check-circle-fill me-1"></i>Resuelto
                                        </span>
                                    @else
                                        <span class="badge bg-secondary-subtle text-secondary border border-secondary rounded-pill px-3">{{ ucfirst($reporte->estado) }}</span>
                                    @endif
                                </div>
                            </div>
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="d-flex align-items-center">
                                        @if($reporte->usuario->avatar_url ?? false)
                                            <img src="{{ $reporte->usuario->avatar_url }}" class="rounded-circle me-2" width="24" height="24" alt="Avatar">
                                        @else
                                            <div class="rounded-circle bg-gray-200 text-secondary d-flex align-items-center justify-content-center me-2 fw-bold" style="width: 24px; height: 24px; font-size: 10px; background-color: #f1f5f9;">
                                                {{ substr($reporte->usuario->nombre ?? 'U', 0, 1) }}
                                            </div>
                                        @endif
                                        <small class="text-muted fw-semibold">{{ $reporte->usuario->nombre ?? 'N/A' }}</small>
                                    </div>
                                    <small class="text-muted">
                                        <i class="bi bi-calendar3 me-1"></i>{{ $reporte->created_at->format('d/m/Y') }}
                                    </small>
                                </div>
                                <a href="{{ route('reportes.show', $reporte->id) }}" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                    Ver detalles
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                @empty
                <div class="activity-item text-center py-5">
                    <div class="bg-light rounded-circle d-inline-flex p-3 mb-3">
                        <i class="bi bi-inbox fs-1 text-muted"></i>
                    </div>
                    <h5 class="text-muted fw-semibold">No hay reportes recientes</h5>
                    <p class="text-muted small">Los reportes nuevos aparecerán aquí</p>
                </div>
                @endforelse
            </div>
        </div>
    </div>
    
    <!-- Columna Lateral (Usuarios y Categorías) -->
    <div class="col-12 col-xl-4">
        <div class="row g-4">
            <!-- Nuevos Usuarios -->
            <div class="col-12">
                <div class="activity-card">
                    <div class="card-header bg-white border-0 py-4 px-4">
                        <h5 class="mb-1 fw-bold">
                            <i class="bi bi-person-plus text-primary me-2"></i>
                            Nuevos Usuarios
                        </h5>
                        <p class="text-muted small mb-0">Últimos registros en la comunidad</p>
                    </div>
                    <div class="card-body p-0">
                        @forelse($nuevosUsuarios ?? [] as $usuario)
                        <div class="activity-item">
                            <div class="d-flex align-items-center">
                                <div class="flex-shrink-0 me-3">
                                    @if($usuario->avatar_url)
                                        <img src="{{ $usuario->avatar_url }}" class="rounded-circle shadow-sm" width="45" height="45" alt="Avatar">
                                    @else
                                        <div class="user-avatar bg-success-subtle text-success rounded-4 fw-bold fs-5">
                                            {{ substr($usuario->nombre, 0, 1) }}
                                        </div>
                                    @endif
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1 fw-bold text-dark">{{ $usuario->nombre }}</h6>
                                    <small class="text-muted d-block mb-1">{{ Str::limit($usuario->email, 22) }}</small>
                                    <span class="badge bg-light text-secondary border rounded-pill">
                                        <i class="bi bi-clock me-1"></i>{{ $usuario->created_at->diffForHumans(null, true, true) }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        @empty
                        <div class="activity-item text-center py-4">
                            <p class="text-muted small mb-0">No hay usuarios nuevos</p>
                        </div>
                        @endforelse
                    </div>
                </div>
            </div>
            
            <!-- Categorías Populares (LISTA) -->
            <div class="col-12">
                <div class="activity-card">
                    <div class="card-header bg-white border-0 py-4 px-4">
                        <h5 class="mb-1 fw-bold">
                            <i class="bi bi-tags text-primary me-2"></i>
                            Top Categorías
                        </h5>
                        <p class="text-muted small mb-0">Mayor actividad histórica</p>
                    </div>
                    <div class="card-body px-4 pb-4">
                        @forelse($categoriasPopulares ?? [] as $categoria)
                        <div class="d-flex align-items-center mb-3">
                            <div class="flex-grow-1">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="fw-bold" style="color: {{ $categoria->color }};">
                                        <i class="bi bi-circle-fill me-2 small"></i>{{ $categoria->nombre }}
                                    </span>
                                    <span class="fw-bold text-dark">{{ $categoria->reportes_count }}</span>
                                </div>
                                <div class="progress" style="height: 6px; border-radius: 10px; background-color: #f1f5f9;">
                                    <div class="progress-bar" role="progressbar" 
                                         style="width: {{ $totalReportes > 0 ? ($categoria->reportes_count / $totalReportes) * 100 : 0 }}%; background-color: {{ $categoria->color }}; border-radius: 10px;" 
                                         aria-valuenow="{{ $categoria->reportes_count }}" aria-valuemin="0" aria-valuemax="{{ $totalReportes }}"></div>
                                </div>
                            </div>
                        </div>
                        @empty
                        <div class="text-center py-4">
                            <p class="text-muted small mb-0">No hay datos disponibles</p>
                        </div>
                        @endforelse
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    // Gráfico de Tipo de Reportes - Solo Perdidos vs Resueltos
    const tipoCtx = document.getElementById('tipoReportesChart');
    if (tipoCtx) {
        new Chart(tipoCtx, {
            type: 'doughnut',
            data: {
                labels: ['Perdidos (Activos)', 'Resueltos'],
                datasets: [{
                    data: [{{ $reportesPerdidos ?? 0 }}, {{ $reportesResueltos ?? 0 }}],
                    backgroundColor: [
                        'rgba(239, 68, 68, 0.8)',
                        'rgba(37, 99, 235, 0.8)'
                    ],
                    borderColor: [
                        '#ef4444',
                        '#2563eb'
                    ],
                    borderWidth: 3,
                    hoverOffset: 15
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            font: { size: 13, weight: '600' },
                            usePointStyle: true,
                            pointStyle: 'circle'
                        }
                    },
                    tooltip: {
                         backgroundColor: 'rgba(0, 0, 0, 0.85)',
                         padding: 15,
                         cornerRadius: 10
                    }
                },
                cutout: '65%'
            }
        });
    }

    // Gráfico de Categorías - Bar Chart con Data Real
    const catCtx = document.getElementById('categoriasChart');
    if (catCtx) {
        // Preparamos los datos desde PHP
        const catLabels = {!! json_encode($categoriasPopulares->pluck('nombre')) !!};
        const catData = {!! json_encode($categoriasPopulares->pluck('reportes_count')) !!};
        const catColors = {!! json_encode($categoriasPopulares->pluck('color')) !!};

        new Chart(catCtx, {
            type: 'bar',
            data: {
                labels: catLabels,
                datasets: [{
                    label: 'Reportes',
                    data: catData,
                    backgroundColor: catColors.map(c => c + 'CC'), // Add transparency
                    borderColor: catColors,
                    borderWidth: 2,
                    borderRadius: 8,
                    barPercentage: 0.6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                indexAxis: 'y', // Horizontal bars look better for categories
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.85)',
                        padding: 12,
                        cornerRadius: 8
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { font: { weight: '600' } }
                    },
                    y: {
                        grid: { color: '#f1f5f9' },
                        ticks: { font: { weight: '600' }, color: '#475569' }
                    }
                }
            }
        });
    }

    // Auto-refresh (30s)
    setTimeout(() => window.location.reload(), 30000);
</script>
@endpush
