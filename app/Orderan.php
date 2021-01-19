<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Orderan extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_orderan';

    protected $fillable = ['no_order','tgl_terima','tgl_selesai','catatan'];
}
