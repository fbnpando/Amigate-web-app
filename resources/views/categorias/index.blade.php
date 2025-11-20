{{-- resources/views/categorias/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Categorías')
@section('page-title', 'Gestión de Categorías')

@section('content')
<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0"><i class="bi bi-tags me-2"></i>Lista de Categorías</h5>
        <a href="{{ route('categorias.create') }}" class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i> Nueva Categoría
        </a>
    </div>
    <div class="card-body">
        <div class="row">
            @foreach($categorias as $categoria)
            <div class="col-md-4 mb-3">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="badge fs-5 mb-2" style="background-color: {{ $categoria->color }}">
                                    <i class="bi bi-{{ $categoria->icono }}"></i> {{ $categoria->nombre }}
                                </span>
                                <p class="text-muted small mb-2">{{ $categoria->descripcion }}</p>
                                <p class="mb-0">
                                    <span class="badge bg-secondary">{{ $categoria->reportes_count }} reportes</span>
                                    @if($categoria->activo)
                                        <span class="badge bg-success">Activo</span>
                                    @else
                                        <span class="badge bg-danger">Inactivo</span>
                                    @endif
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-white">
                        <div class="btn-group btn-group-sm w-100">
                            <a href="{{ route('categorias.show', $categoria->id) }}" class="btn btn-info">
                                <i class="bi bi-eye"></i> Ver
                            </a>
                            <a href="{{ route('categorias.edit', $categoria->id) }}" class="btn btn-warning">
                                <i class="bi bi-pencil"></i> Editar
                            </a>
                            <form action="{{ route('categorias.destroy', $categoria->id) }}" method="POST" class="d-inline" onsubmit="return confirmarEliminacion(this)">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-danger">
                                    <i class="bi bi-trash"></i> Eliminar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</div>
@endsection