<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLabSpkTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lab_spk', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('no_order');
            $table->integer('petugas_id');
            $table->integer('alat_id');
            $table->integer('unit_kerja');
            $table->integer('ka_instalasi');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lab_spk');
    }
}
