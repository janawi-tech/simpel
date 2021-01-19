<?php

use Illuminate\Database\Seeder;

class MatkulTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('matkul')->insert([
            'id_matkul'     => 'SKB-351',
            'name'   		=> 'Perancangan Basis Data (Pilihan I)',
            'sks' 			=> 3,
        ]);
    }
}
