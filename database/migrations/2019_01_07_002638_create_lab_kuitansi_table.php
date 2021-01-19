<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLabKuitansiTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lab_kuitansi', function (Blueprint $table) {
            $table->increments('id');
            $table->string('no_bukti',50);
            $table->string('no_order',50);
            $table->string('tgl_bayar',20);
            $table->integer('customer_id');
            $table->string('dari',50);
            $table->string('keterangan');
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
        Schema::dropIfExists('lab_kuitansi');
    }
}
