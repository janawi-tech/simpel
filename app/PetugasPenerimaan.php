<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PetugasPenerimaan extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_ptg_penerimaan';

    protected $fillable = [
        'id_order',
    	'no_order',
    	'name',
    	'ptg1',
    	'ptg2',
    	'kup',
    	'kkl',
    	'kpp',
    	'bpj',
    	'kpr',
    	'kmk',
    	'akl'
    ];
}
