<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Bukti extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_bukti';

    protected $fillable = ['id_order','no_order','alat_id','tgl_serah','penyerah','penerima','p1','p2','p3','p4'];
}
