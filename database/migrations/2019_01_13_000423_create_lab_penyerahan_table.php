<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLabPenyerahanTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lab_penyerahan', function (Blueprint $table) {
            $table->increments('id');
            $table->string('tgl_serah',20);
            $table->string('no_order',50);
            $table->integer('petugas_lab');
            $table->integer('petugas_yantek');
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
        Schema::dropIfExists('lab_penyerahan');
    }
}
