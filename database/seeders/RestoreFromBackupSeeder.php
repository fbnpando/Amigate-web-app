<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;

class RestoreFromBackupSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $backupPath = base_path('backup.sql');

        if (!File::exists($backupPath)) {
            $this->command->error("Backup file not found at: {$backupPath}");
            return;
        }

        $content = File::get($backupPath);
        
        // 1. Restore Cuadrantes
        $this->command->info('Restoring Cuadrantes...');
        $this->restoreTableFromCopy($content, 'cuadrantes', [
            'id', 'codigo', 'fila', 'columna', 'nombre', 'geometria', 'centro', 
            'lat_min', 'lat_max', 'lng_min', 'lng_max', 'ciudad', 'zona', 'barrios', 
            'activo', 'created_at', 'centro_lat', 'centro_lng'
        ]);

        // 2. Restore Grupos
        $this->command->info('Restoring Grupos...');
        $this->restoreTableFromCopy($content, 'grupos', [
            'id', 'cuadrante_id', 'nombre', 'descripcion', 'imagen_url', 
            'publico', 'requiere_aprobacion', 'miembros_count', 
            'reportes_activos_count', 'reportes_resueltos_count', 'created_at', 'updated_at'
        ]);
        
        // 3. Restore Categorias (Optional but useful)
        $this->command->info('Restoring Categorias...');
        $this->restoreTableFromCopy($content, 'categorias', [
            'id', 'nombre', 'icono', 'color', 'descripcion', 'activo', 'created_at'
        ]);
    }

    private function restoreTableFromCopy(string $content, string $tableName, array $columns)
    {
        // Regex to find the COPY block
        // Looks for "COPY public.tableName (...) FROM stdin;"
        // Then captures everything until "\."
        $pattern = "/COPY public\.{$tableName} \((.*?)\) FROM stdin;\n(.*?)\n\\\\./s";
        
        if (preg_match($pattern, $content, $matches)) {
            $dataBlock = $matches[2];
            $rows = explode("\n", $dataBlock);
            $count = 0;

            foreach ($rows as $row) {
                if (empty(trim($row))) continue;

                $values = explode("\t", $row);
                
                // Map values to columns
                $insertData = [];
                foreach ($columns as $index => $column) {
                    $value = $values[$index] ?? null;
                    
                    // Handle Postgres COPY null format "\N"
                    if ($value === '\N') {
                        $value = null;
                    }
                    
                    // Clean boolean values 't'/'f' if necessary, though Laravel/PDO handles valid bools often.
                    // Postgres uses 't' and 'f' for booleans.
                    if ($value === 't') $value = true;
                    if ($value === 'f') $value = false;

                    $insertData[$column] = $value;
                }

                // Insert into DB
                try {
                    // Check if exists to avoid duplicates
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
