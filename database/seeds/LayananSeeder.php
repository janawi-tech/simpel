<?php

use Illuminate\Database\Seeder;

class LayananSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('layanan')->insert(
        	['layanan'   		=> 'Kalibrasi']
        );
    }
}
