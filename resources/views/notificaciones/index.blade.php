
{{-- resources/views/notificaciones/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Notificaciones')
@section('page-title', 'Gestión de Notificaciones')

@section('content')
<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="bi bi-bell me-2"></i>Lista de Notificaciones</h5>
    </div>
    <div class="card-body">
        <div class="list-group">
            @foreach($notificaciones as $notificacion)
            <div class="list-group-item {{ $notificacion->leida ? '' : 'list-group-item-info' }}">
                <div class="d-flex w-100 justify-content-between align-items-start">
                    <div>
                        <h6 class="mb-1">
                            @if(!$notificacion->leida)
                                <span class="badge bg-primary">Nueva</span>
                            @endif
                            {{ $notificacion->titulo }}
                        </h6>
                        <p class="mb-1">{{ $notificacion->mensaje }}</p>
                        <small class="text-muted">
                            <i class="bi bi-person"></i> {{ $notificacion->usuario->nombre }}
                        </small>
                    </div>
                    <small class="text-muted">{{ $notificacion->created_at->diffForHumans() }}</small>
                </div>
            </div>
            @endforeach
        </div>
        
        <div class="mt-3">
            {{ $notificaciones->links() }}
        </div>
    </div>
</div>
@endsection