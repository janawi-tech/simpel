<?php

use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            'name'     => 'Moch. Arif Afianto',
            'email'  => 'afoantoarif68@gmail.com',
            'password'  => Hash::make('Le_gratha@02')
        ]);
    }
}
