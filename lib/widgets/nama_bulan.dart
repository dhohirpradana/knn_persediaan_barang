String bulanNama(bulan) {
  return (bulan == 1)
      ? 'Januari'
      : (bulan == 2)
          ? 'Februari'
          : (bulan == 3)
              ? 'Maret'
              : (bulan == 4)
                  ? 'April'
                  : (bulan == 5)
                      ? 'Mei'
                      : (bulan == 6)
                          ? 'Juni'
                          : (bulan == 7)
                              ? 'Juli'
                              : (bulan == 8)
                                  ? 'Agustus'
                                  : (bulan == 9)
                                      ? 'September'
                                      : (bulan == 10)
                                          ? 'Oktober'
                                          : (bulan == 11)
                                              ? 'November'
                                              : 'Desember';
}
