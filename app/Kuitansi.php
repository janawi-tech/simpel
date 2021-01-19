<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Kuitansi extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_kuitansi';

    protected $fillable = ['no_bukti','no_order','tgl_bayar','customer_id','dari','keterangan'];
}
