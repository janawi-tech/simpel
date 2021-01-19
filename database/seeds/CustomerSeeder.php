<?php

use Illuminate\Database\Seeder;

class CustomerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('customer')->insert([
            'name'     => 'Puskesmas Banjarbaru',
            'address'  => 'Jl. Salak No.20 Banjarbaru',
        ]);
    }
}
