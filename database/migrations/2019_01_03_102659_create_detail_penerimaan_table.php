<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDetailPenerimaanTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detail_penerimaan', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('no_order');
            $table->integer('customer_id');
            $table->integer('alat_id');
            $table->string('merek');
            $table->string('model');
            $table->string('seri');
            $table->integer('jumlah');
            $table->integer('fungsi')->default(1);
            $table->string('kelengkapan');
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
        Schema::dropIfExists('detail_penerimaan');
    }
}
