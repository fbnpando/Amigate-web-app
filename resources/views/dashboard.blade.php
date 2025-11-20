@extends('layouts.app')

@section('title', 'Dashboard - Objetos Perdidos')
@section('page-title', 'Dashboard')

@section('content')
<div class="row">
    <!-- Estadísticas -->
    <div class="col-md-3">
        <div class="stats-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1">Total Reportes</h6>
                    <h2 class="mb-0">{{ $totalReportes ?? 0 }}</h2>
                </div>
                <i class="bi bi-file-earmark-text"></i>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stats-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1">Usuarios</h6>
                    <h2 class="mb-0">{{ $totalUsuarios ?? 0 }}</h2>
                </div>
                <i class="bi bi-people"></i>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stats-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1">Activos</h6>
                    <h2 class="mb-0">{{ $reportesActivos ?? 0 }}</h2>
                </div>
                <i class="bi bi-check-circle"></i>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stats-card" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1">Resueltos</h6>
                    <h2 class="mb-0">{{ $reportesResueltos ?? 0 }}</h2>
                </div>
                <i class="bi bi-check2-all"></i>
            </div>
        </div>
    </div>
</div>

<!-- Reportes por Tipo y Prioridad -->
<div class="row mt-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-pie-chart me-2"></i>Reportes por Tipo</h5>
            </div>
            <div class="card-body">
                <canvas id="tipoReportesChart"></canvas>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-bar-chart me-2"></i>Reportes por Prioridad</h5>
            </div>
            <div class="card-body">
                <canvas id="prioridadChart"></canvas>
            </div>
        </div>
    </div>
</div>

<!-- Últimos Reportes -->
<div class="row mt-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="bi bi-clock-history me-2"></i>Últimos Reportes</h5>
                <a href="{{ route('reportes.index') }}" class="btn btn-sm btn-primary">Ver todos</a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Tipo</th>
                                <th>Categoría</th>
                                <th>Usuario</th>
                                <th>Estado</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($ultimosReportes ?? [] as $reporte)
                            <tr>
                                <td>
                                    <strong>{{ Str::limit($reporte->titulo, 50) }}</strong>
                                </td>
                                <td>
                                    <span class="badge bg-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }}">
                                        {{ ucfirst($reporte->tipo_reporte) }}
                                    </span>
                                </td>
                                <td>{{ $reporte->categoria->nombre ?? 'N/A' }}</td>
                                <td>{{ $reporte->usuario->nombre ?? 'N/A' }}</td>
                                <td>
                                    @if($reporte->estado == 'activo')
                                        <span class="badge bg-primary">Activo</span>
                                    @elseif($reporte->estado == 'resuelto')
                                        <span class="badge bg-success">Resuelto</span>
                                    @else
                                        <span class="badge bg-secondary">{{ ucfirst($reporte->estado) }}</span>
                                    @endif
                                </td>
                                <td>{{ $reporte->created_at->format('d/m/Y H:i') }}</td>
                                <td>
                                    <a href="{{ route('reportes.show', $reporte->id) }}" class="btn btn-sm btn-info">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </td>
                            </tr>
                            @empty
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox" style="font-size: 2rem;"></i>
                                    <p class="mb-0 mt-2">No hay reportes registrados</p>
                                </td>
                            </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Actividad Reciente -->
<div class="row mt-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-person-plus me-2"></i>Nuevos Usuarios</h5>
            </div>
            <div class="card-body">
                <div class="list-group list-group-flush">
                    @forelse($nuevosUsuarios ?? [] as $usuario)
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <i class="bi bi-person-circle me-2"></i>
                            <strong>{{ $usuario->nombre }}</strong>
                            <br>
                            <small class="text-muted">{{ $usuario->email }}</small>
                        </div>
                        <small class="text-muted">{{ $usuario->created_at->diffForHumans() }}</small>
                    </div>
                    @empty
                    <p class="text-muted text-center py-3">No hay usuarios nuevos</p>
                    @endforelse
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-tags me-2"></i>Categorías Populares</h5>
            </div>
            <div class="card-body">
                @forelse($categoriasPopulares ?? [] as $categoria)
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <span class="badge" style="background-color: {{ $categoria->color }};">
                            {{ $categoria->nombre }}
                        </span>
                    </div>
                    <span class="badge bg-secondary">{{ $categoria->reportes_count }} reportes</span>
                </div>
                @empty
                <p class="text-muted text-center py-3">No hay datos disponibles</p>
                @endforelse
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    // Gráfico de Tipo de Reportes
    const tipoCtx = document.getElementById('tipoReportesChart');
    if (tipoCtx) {
        new Chart(tipoCtx, {
            type: 'doughnut',
            data: {
                labels: ['Perdidos', 'Encontrados'],
                datasets: [{
                    data: [{{ $reportesPerdidos ?? 0 }}, {{ $reportesEncontrados ?? 0 }}],
                    backgroundColor: ['#FF6B6B', '#51CF66'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    }

    // Gráfico de Prioridad
    const prioridadCtx = document.getElementById('prioridadChart');
    if (prioridadCtx) {
        new Chart(prioridadCtx, {
            type: 'bar',
            data: {
                labels: ['Baja', 'Normal', 'Alta', 'Urgente'],
                datasets: [{
                    label: 'Reportes',
                    data: [
                        {{ $reportesBaja ?? 0 }},
                        {{ $reportesNormal ?? 0 }},
                        {{ $reportesAlta ?? 0 }},
                        {{ $reportesUrgente ?? 0 }}
                    ],
                    backgroundColor: ['#51CF66', '#4ECDC4', '#FFD93D', '#FF6B6B'],
                    borderWidth: 0,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    }
</script>
@endpush