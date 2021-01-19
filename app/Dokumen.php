<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Dokumen extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_dokumen';

    protected $fillable = ['id_order','dok1','dok2'];
}
