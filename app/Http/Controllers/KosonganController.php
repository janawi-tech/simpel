<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Elibyy\TCPDF\Facades\TCPDF;
use Carbon\Carbon;
use Redirect;
use Response;
use DB;
use Auth;

class KosonganController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $pdf = new TCPDF();
        $pdf::setHeaderCallback(function($pdf) {
            // $pdf->SetFont('helvetica', 'B', 20);
            // $pdf->Cell(0, 15, 'Something new right here!!!', 0, false, 'C', 0, '', 0, false, 'M', 'M');
        });
        $pdf::setFooterCallback(function($pdf) {
            $style = array(
                'position' => '',
                'align' => 'L',
                'stretch' => true,
                'fitwidth' => true,
                'hpadding' => 'auto',
                'vpadding' => 'auto',
                'font' => 'helvetica',
                'text' => true,
                'font' => 'helvetica',
                'fontsize' => 5,
                'stretchtext' => 4
            );
            $pdf->SetY(200);
            $pdf->write1DBarcode(Carbon::now()->format('d-m-Y H:i:s').'', 'C128A', 3.5, '', 50, 8, 0.4, $style, 'N');
            $pdf->SetY(198);
            $pdf->SetX(60);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>*Perhatian :</i>', true, 0, true, 0);

            $pdf->SetY(198);
            $pdf->SetX(75);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>- Isi berita acara ini telah disetujui oleh pelanggan</i>', true, 0, true, 0);
            $pdf->SetY(201);
            $pdf->SetX(75);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>- Data sertifikat yang akan diterbitkan sama dengan data yang ada pada berita acara ini</i>', true, 0, true, 0);
            $pdf->SetY(204);
            $pdf->SetX(75);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>- Tidak dibenarkan memperbanyak, mengutip atau memiliki sebagian/keseluruhan isi dokumen ini tanpa izin dari LPFK Banjarbaru</i>', true, 0, true, 0);
            $pdf->SetY(192);
            $pdf->SetX(23.5);

            $pdf->Cell(520, 25, 'Hal  ...  dari  ...', 0, false, 'C', 0, '', 0, false, 'T', 'M');
        });
        $pdf::setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf::SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        $pdf::SetAutoPageBreak(TRUE, 11);
        $pdf::SetMargins(5.5, 5.5);
        $pdf::setCellHeightRatio(1);
        $pdf::SetTitle('Cetak Order');
        $pdf::AddPage('L', 'A4');

        $style = array(
            'border' => 0,
            'padding' => 0,
            'fgcolor' => array(0,0,0),
            'bgcolor' => false,//array(255,255,255),
            'module_width' => 1, // width of a single module in points
            'module_height' => 1 // height of a single module in points
        );

        $table_order='<table border="1" cellpadding="3" cellspacing="0">
                        <tr>
                            <td rowspan="3" colspan="2" style="text-align:center" width="405px">
                                <img src="img/kop.png" width="320px"/>
                            </td>
                            <td colspan="2" align="center" style="font-size:11px" width="405px">
                                <b>BUKTI PENERIMAAN PEKERJAAN KALIBRASI ALAT KESEHATAN</b>
                            </td>
                        </tr>
                        <tr>
                            <td><font size="8em">Nomor Order : </font></td>
                            <td><font size="8em">Tanggal Terima : </font></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Pekerjaan diperkirakan selesai tanggal : </font></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table border="0" cellpadding="1.5" cellspacing="0">
                                    <tr>
                                        <td><font size="8em">Pemilik Barang</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em"></font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Alamat</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em"></font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Telepon/Faksimili</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em"></font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Contact Person:</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Telp./HP&nbsp;&nbsp;:&nbsp;&nbsp;</font></td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2">
                                <table border="0">
                                    <tr align="center">
                                        <td><font size="8em">Yang Menyerahkan Barang</font></td>
                                        <td><font size="8em">Penerima Alat</font></td>
                                        <td><font size="8em">Pemeriksa Alat</font></td>
                                    </tr>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr align="center">
                                        <td><font size="8em">...........................</font></td>
                                        <td><font size="8em">...........................</font></td>
                                        <td><font size="8em">...........................</font></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>';

        $isi='';
        for ($no=0; $no < 19 ; $no++) { 
            $isi=$isi.'<tr nobr="true">
                            <td width="20px" align="center"><font size="8em">'.($no+1).'</font></td>
                            <td width="140px" ><font size="8em"></font></td>
                            <td width="80px" ><font size="8em"></font></td>
                            <td width="80px" ><font size="8em"></font></td>
                            <td width="85px" ><font size="8em"></font></td>
                            <td width="50px"  align="center"><font size="8em"></font></td>
                            <td width="60px" ><font size="8em"></font></td>
                            <td width="50px" ><font size="8em"></font></td>
                            <td width="150px" ><font size="8em"></font></td>
                            <td width="95px" ><font size="8em"></font></td>
                       </tr>';
        }      

        $pdf::SetFont('helvetica', '', 9);

        
        $table_det_order=$table_order.'
                    <table border="1" cellpadding="2" cellspacing="0" width="100%">
                        <thead>
                            <tr align="center" nobr="true">
                                <th rowspan="2" width="20px"><font size="8em"><br>No</font></th>
                                <th rowspan="2" width="140px"><font size="8em"><br>Nama Alat</font></th>
                                <th rowspan="2" width="80px"><font size="8em"><br>Merek</font></th>
                                <th rowspan="2" width="80px"><font size="8em"><br>Model/Type</font></th>
                                <th rowspan="2" width="85px"><font size="8em"><br>No. Seri</font></th>
                                <th rowspan="2" width="50px"><font size="8em"><br>Jumlah</font></th>
                                <th rowspan="2" width="60px"><font size="8em"><br>Harga Satuan (Rp)</font></th>
                                <th colspan="2" width="200px"><font size="8em">Pengecekan</font></th>
                                <th rowspan="2" width="95px"><font size="8em">Keterangan</font></th>
                            </tr>
                            <tr align="center">
                                <th width="50px"><font size="8em">Fungsi</font></th>
                                <th width="150px"><font size="8em">Aksesoris</font></th>
                            </tr>
                        </thead>
                        <tbody>
                            '.$isi.'
                            <tr>
                                <td colspan="6" style="text-align:right"><font size="8em">Total</font></td>
                                <td colspan="4" style="text-align:left"><font size="8em"></font></td>
                            </tr>
                        </tbody>
                    </table>';
        $tabelcatat='<table border="1" cellpadding="2" cellspacing="0">
                        <tr>
                            <td colspan="7" rowspan="8" style="text-align:justify" width="565px"><font size="8em">Catatan :<br></font></td>
                            <td colspan="2" width="150px"><font size="8em">Kaji Ulang Permintaan</font></td>
                            <td align="center" width="95"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kemampuan Kalibrasi</font></td>
                            <td align="center"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kesiapan Petugas</font></td>
                            <td align="center"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Beban Pekerjaan</font></td>
                            <td align="center"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kondisi Peralatan</font></td>
                            <td align="center"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kesesuaian Metode Kalibrasi</font></td>
                            <td align="center"></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Akomodasi & Lingkungan</font></td>
                            <td align="center"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><font size="7em">*)Ket : <img src="img/check.png" height="5"/> Memungkinkan &nbsp;&nbsp; *)Ket : <img src="img/remove.png" height="5"/> Tidak Memungkinkan</font></td>
                        </tr>
                        <tr>
                            <td width="810px">
                                <table border="0">
                                    <tr>
                                        <td><font size="8em">Lembar 1&nbsp;&nbsp;:&nbsp;&nbsp;Untuk Pelanggan</font></td>
                                        <td rowspan="2" align="right" style="vertical-align:middle"><font face="courier" size="8em">&nbsp;SOP LPFK.03.12 REV.2</font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Lembar 2&nbsp;&nbsp;:&nbsp;&nbsp;Untuk Personal Pelayanan Teknis</font></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>';

        $pdf::writeHTML($table_det_order.$tabelcatat, true, false, true, false, '');
        
        $pdf::lastPage();
        $pdf::Output('ba-kosong.pdf');
    }


}
