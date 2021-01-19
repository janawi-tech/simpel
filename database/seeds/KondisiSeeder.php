<?php

use Illuminate\Database\Seeder;

class KondisiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('lab_kondisi')->insert([
            'kondisi'   		=> 'Tidak Baik'
        ]);
    }
}
