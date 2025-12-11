<?php



namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Categoria extends Model
{
    use HasUuids;

    protected $table = 'categorias';
    public $incrementing = false;
    protected $keyType = 'string';
    const UPDATED_AT = null;

    protected $fillable = [
        'nombre', 'icono', 'color', 'descripcion', 'activo'
    ];

    protected $casts = [
        'activo' => 'boolean'
    ];

    public function reportes()
    {
        return $this->hasMany(Reporte::class, 'categoria_id');
    }
}