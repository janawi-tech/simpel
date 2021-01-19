<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePtgPenerimaanTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ptg_penerimaan', function (Blueprint $table) {
            $table->increments('id');
            $table->string('no_order');
            $table->string('name');
            $table->integer('ptg1');
            $table->integer('ptg2');
            $table->integer('kup')->default(0);
            $table->integer('kkl')->default(0);
            $table->integer('kpp')->default(0);
            $table->integer('bpj')->default(0);
            $table->integer('kpr')->default(0);
            $table->integer('kmk')->default(0);
            $table->integer('akl')->default(0);
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
        Schema::dropIfExists('ptg_penerimaan');
    }
}
