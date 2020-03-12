class Burger < ApplicationRecord
    def get_nutriments
        # Créé un nouveau tableau
        res = Array.new
        # si le code du burger n'est pas nul
        if(!self.code.nil?)
            # on recherche l'objet correspondant au code
            product = Openfoodfacts::Product.get(self.code, locale: 'fr')
            # si le produit correspondant existe
            if(product.present?)
                # alors on recherche ses nutriments
                nutri = product.nutriments.to_hash
                # S'il en a
                if nutri.count != 0
                    # pour chacun des nutriments
                    for ele in nutri
                        # si il n'est pas une donnee d'unite
                        if !ele[0].to_s.include? "unit"
                            nutri = Array.new
                            nutri.push(ele[0].to_s.gsub('_', ' ').gsub('-', ' '))
                            nutri.push(ele[1].to_s.gsub('_', ' ').gsub('-', ' '))
                            # on l'ajoute a notre tableau
                            res.push(nutri)
                         end
                    end
                end
            end
        end

        if(res.count == 0)
            nutri = Array.new
            nutri.push("No element")
            nutri.push("ZERO NULL NADA QUE TCHI GUCCI")
            # on l'ajoute a notre tableau
            res.push(nutri)
        end
        return res
    end
end