<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class RestoreFromBackupSeeder extends Seeder
{
    public function run(): void
    {
        $backupPath = base_path('backup.sql');

        if (!File::exists($backupPath)) {
            $this->command->error("Backup file not found at: {$backupPath}");
            return;
        }

        $content = File::get($backupPath);

        // 1. Restore Cuadrantes
        $this->restoreTableFromCopy($content, 'cuadrantes', [
            'id', 'codigo', 'fila', 'columna', 'nombre', 'geometria', 'centro', 
            'lat_min', 'lat_max', 'lng_min', 'lng_max', 'ciudad', 'zona', 'barrios', 
            'activo', 'created_at', 'centro_lat', 'centro_lng'
        ]);

        // 2. Restore Grupos
        // COPY public.grupos (id, cuadrante_id, nombre, descripcion, imagen_url, publico, requiere_aprobacion, miembros_count, reportes_activos_count, reportes_resueltos_count, created_at, updated_at) FROM stdin;
        $this->restoreTableFromCopy($content, 'grupos', [
            'id', 'cuadrante_id', 'nombre', 'descripcion', 'imagen_url', 'publico', 
            'requiere_aprobacion', 'miembros_count', 'reportes_activos_count', 
            'reportes_resueltos_count', 'created_at', 'updated_at'
        ]);

        // 3. Restore Categorias
        // COPY public.categorias (id, nombre, icono, color, descripcion, activo, created_at, updated_at) FROM stdin;
        $this->restoreTableFromCopy($content, 'categorias', [
            'id', 'nombre', 'icono', 'color', 'descripcion', 'activo', 'created_at', 'updated_at'
        ]);
        
        $this->command->info('✅ Data restoration from backup completed!');
    }

    private function restoreTableFromCopy(string $content, string $tableName, array $columns)
    {
        // Regex to find the COPY block - flexible for line endings
        $pattern = "/COPY public\.{$tableName} \((.*?)\) FROM stdin;[\r\n]+(.*?)[\r\n]+\\\./s";
        
        if (preg_match($pattern, $content, $matches)) {
            $dataBlock = $matches[2];
            $rows = explode("\n", $dataBlock);
            $count = 0;

            foreach ($rows as $row) {
                if (empty(trim($row))) continue;

                $values = explode("\t", $row);
                
                $insertData = [];
                foreach ($columns as $index => $column) {
                    $value = $values[$index] ?? null;
                    
                    if ($value === '\N') {
                        $value = null;
                    }
                    
                    if ($value === 't') $value = true;
                    if ($value === 'f') $value = false;

                    $insertData[$column] = $value;
                }

                try {
                    // Check if record exists to avoid duplicates
                    if (!DB::table($tableName)->where('id', $insertData['id'])->exists()) {
                        DB::table($tableName)->insert($insertData);
                        $count++;
                    }
                } catch (\Exception $e) {
                    $this->command->warn("Failed to insert row in {$tableName}: " . $e->getMessage());
                }
            }
            $this->command->info("Inserted {$count} rows into {$tableName}.");
        } else {
            $this->command->warn("No COPY block found for table {$tableName} in backup.sql");
        }
    }
}
