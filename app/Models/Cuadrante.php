<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Cuadrante extends Model
{
    use HasUuids;

    protected $table = 'cuadrantes';
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';
    const UPDATED_AT = null;

    protected $fillable = [
        'codigo',
        'fila',
        'columna',
        'nombre',
        'lat_min',
        'lat_max',
        'lng_min',
        'lng_max',
        'centro_lat',
        'centro_lng',
        'ciudad',
        'zona',
        'activo'
    ];

    protected $casts = [
        'columna' => 'integer',
        'lat_min' => 'decimal:8',
        'lat_max' => 'decimal:8',
        'lng_min' => 'decimal:8',
        'lng_max' => 'decimal:8',
        'centro_lat' => 'decimal:8',
        'centro_lng' => 'decimal:8',
        'activo' => 'boolean',
        'created_at' => 'datetime'
    ];

    public function barrios()
    {
        return $this->hasMany(CuadranteBarrio::class, 'cuadrante_id');
    }

    public function reportes()
    {
        return $this->hasMany(Reporte::class, 'cuadrante_id');
    }

    public function grupos()
    {
        return $this->hasMany(Grupo::class, 'cuadrante_id');
    }

    public function expansiones()
    {
        return $this->hasMany(ExpansionReporte::class, 'cuadrante_expandido_id');
    }
}