<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Penyerahan extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_penyerahan';

    protected $fillable = ['id_order','tgl_serah','no_order','petugas_lab','petugas_yantek','catatan'];
}
