<?php

use Illuminate\Database\Seeder;

class GroupAdminsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('lab_admins_group')->insert(
        	['groups'     => 'Staf Teknis']
        );
    }
}
