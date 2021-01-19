<?php

use Illuminate\Database\Seeder;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('admins')->insert(
        	// [
	        //     'name'     => 'Fatimah Novrianisa',
	        //     'groups'  => '7',
	        //     'email'  => 'fatimah0953',
	        //     'password'  => Hash::make('lpfk160941'),
	        //     'lvl'  => 0
        	// ]
        	// [
	        //     'name'     => 'Septia Khairunnisa',
	        //     'groups'  => '5',
	        //     'email'  => 'lablpfkbjb',
	        //     'password'  => Hash::make('l0951fk'),
	        //     'lvl'  => 0
        	// ]

        	[
	            'name'     => 'Hary Ernanto',
	            'groups'  => '3',
	            'email'  => 'haryer',
	            'password'  => Hash::make('1234567'),
	            'lvl'  => 0
        	]

        	// [
	        //     'name'     => 'M. Irfan Khunuzon',
	        //     'groups'  => '7'
        	// ]
    	);
    }
}
