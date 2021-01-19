<?php

use Illuminate\Database\Seeder;

class GroupMatkulSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('group_matkul')->insert(
        	[
	            'id_group_matkul'     => 'IPK',
	            'name'   			  => 'Iiii Pppp Kkkk'
        	]
        );
    }
}
