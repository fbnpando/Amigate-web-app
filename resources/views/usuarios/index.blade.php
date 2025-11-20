{{-- resources/views/usuarios/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Usuarios')
@section('page-title', 'Gestión de Usuarios')

@section('content')
<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0"><i class="bi bi-people me-2"></i>Lista de Usuarios</h5>
        <a href="{{ route('usuarios.create') }}" class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i> Nuevo Usuario
        </a>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover data-table">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Puntos</th>
                        <th>Estado</th>
                        <th>Fecha Registro</th>
                        <th width="120px">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($usuarios as $usuario)
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                @if($usuario->avatar_url)
                                    <img src="{{ $usuario->avatar_url }}" class="rounded-circle me-2" width="40" height="40">
                                @else
                                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px;">
                                        {{ substr($usuario->nombre, 0, 1) }}
                                    </div>
                                @endif
                                <strong>{{ $usuario->nombre }}</strong>
                            </div>
                        </td>
                        <td>{{ $usuario->email }}</td>
                        <td>{{ $usuario->telefono ?? 'N/A' }}</td>
                        <td>
                            <span class="badge bg-info">{{ $usuario->puntos_ayuda }} pts</span>
                        </td>
                        <td>
                            @if($usuario->activo)
                                <span class="badge bg-success">Activo</span>
                            @else
                                <span class="badge bg-danger">Inactivo</span>
                            @endif
                        </td>
                        <td>{{ $usuario->fecha_registro->format('d/m/Y') }}</td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="{{ route('usuarios.show', $usuario->id) }}" class="btn btn-info" title="Ver">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="{{ route('usuarios.edit', $usuario->id) }}" class="btn btn-warning" title="Editar">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form action="{{ route('usuarios.destroy', $usuario->id) }}" method="POST" class="d-inline" onsubmit="return confirmarEliminacion(this)">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger" title="Eliminar">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection
