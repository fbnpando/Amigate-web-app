<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Models\User;

class RolePermissionSeeder extends Seeder
{
    
    public function run(): void
    {
        
        if (class_exists(\Spatie\Permission\PermissionRegistrar::class)) {
            app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
        } else {
            \Illuminate\Support\Facades\Cache::forget('spatie.permission.cache');
        }

        
        
        
        
        
        Permission::create(['name' => 'ver usuarios']);
        Permission::create(['name' => 'crear usuarios']);
        Permission::create(['name' => 'editar usuarios']);
        Permission::create(['name' => 'eliminar usuarios']);

        
        Permission::create(['name' => 'ver reportes']);
        Permission::create(['name' => 'crear reportes']);
        Permission::create(['name' => 'editar reportes']);
        Permission::create(['name' => 'eliminar reportes']);

        
        Permission::create(['name' => 'ver categorias']);
        Permission::create(['name' => 'crear categorias']);
        Permission::create(['name' => 'editar categorias']);
        Permission::create(['name' => 'eliminar categorias']);

        
        Permission::create(['name' => 'ver grupos']);
        Permission::create(['name' => 'crear grupos']);
        Permission::create(['name' => 'editar grupos']);
        Permission::create(['name' => 'eliminar grupos']);

        
        Permission::create(['name' => 'administrar sistema']);
        Permission::create(['name' => 'ver configuracion']);
        Permission::create(['name' => 'editar configuracion']);

        
        
        

        
        $adminRole = Role::create(['name' => 'administrador']);
        $adminRole->givePermissionTo(Permission::all());

        
        $editorRole = Role::create(['name' => 'editor']);
        $editorRole->givePermissionTo([
            'ver reportes',
            'crear reportes',
            'editar reportes',
            'eliminar reportes',
            'ver categorias',
            'crear categorias',
            'editar categorias',
            'eliminar categorias',
            'ver grupos',
            'crear grupos',
            'editar grupos',
        ]);

        
        $userRole = Role::create(['name' => 'usuario']);
        $userRole->givePermissionTo([
           
        ]);

        
        
        
        
        
        $adminUser = User::where('email', 'admin@amigate.com')->first();
        if ($adminUser) {
            $adminUser->assignRole('administrador');
            $this->command->info("Rol 'administrador' asignado a: {$adminUser->email}");
        }

        
        $users = User::whereDoesntHave('roles')->get();
        foreach ($users as $user) {
            $user->assignRole('usuario');
            $this->command->info("Rol 'usuario' asignado a: {$user->email}");
        }

        $this->command->info('✅ Roles y permisos creados exitosamente!');
    }
}
