<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            'name'     => 'Arif Afianto',
            'email'    => 'afiantoarif78@gmail.com',
            'password' => Hash::make('arifafianto'),
        ]);
    }
}
