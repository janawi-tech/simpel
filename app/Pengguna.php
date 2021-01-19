<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Pengguna extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'admins';

    protected $fillable = ['name','email','groups','nip','password'];
}
