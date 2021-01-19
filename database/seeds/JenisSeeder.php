<?php

use Illuminate\Database\Seeder;

class JenisSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('lab_jenis')->insert(
        	['jenis'   		=> 'Lain - Lain']
        );
    }
}
