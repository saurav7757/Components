public class LegalEntity {
    public static string Convert(string i) {
        switch on i {
            when 'AöR', 'e. V.', 'eG', 'Eigenbetrieb', 'EWIV', 'KöR', 'OTHER (If avoidable, do not use)', 'Regiebetrieb', 'SCE', 'Stiftung', 'VVaG' {
                return 'Sonstige';
            }
            when 'AG & Co. KG', 'AG & Co. OHG', 'GbR', 'GmbH & Co. KG', 'GmbH & Co. OHG', 'KG', 'Limited & Co. KG', 'OHG', 'Partenreederei', 'PartG', 'PartG mbB', 'Stiftung & Co. KG', 'Stiftung GmbH & Co. KG', 'Stille Gesellschaft', 'UG (haftungsbeschränkt) & Co. KG' {
                return 'PersG';
            }
            when 'AG', 'AG & Co. KGaA', 'gAG', 'gGmbH', 'GmbH', 'GmbH & Co. KGaA', 'InvAG', 'KGaA', 'REIT-AG', 'SE', 'SE & Co. KGaA', 'Stiftung & Co. KGaA', 'UG (haftungsbeschränkt)' {
                return 'KapG';
            }
            when 'Einzelunternehmen' {
                return 'EU';
            }
            when else {
               	return 'Sonstige';
            }
        }
    }
}