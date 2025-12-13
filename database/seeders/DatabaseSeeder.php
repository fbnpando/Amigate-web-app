<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    
    public function run(): void
    {
        
        User::factory()->create([
            'name' => 'Administrador',
            'email' => 'admin@amigate.com',
            'password' => \Illuminate\Support\Facades\Hash::make('admin123'),
        ]);

        
        $this->call([
            RolePermissionSeeder::class,
        ]);
    }
}
