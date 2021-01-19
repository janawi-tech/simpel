<?php

use Illuminate\Database\Seeder;

class DosenTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('dosen')->insert(
        	[
	            'id_dosen'     => '1001.025',
	            'name'   	   => 'Ahmad Pahdi, M.Kom',
	            'group_matkul' => 1
        	]
        );
    }
}
