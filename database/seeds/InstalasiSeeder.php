<?php

use Illuminate\Database\Seeder;

class InstalasiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('lab_instalasi')->insert(
        	['instalasi'   		=> 'Instalasi Sarana dan Prasarana']
        );
    }
}
