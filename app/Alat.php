<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Alat extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_alat';

    protected $fillable = ['nama','tarif','layanan'];
}
