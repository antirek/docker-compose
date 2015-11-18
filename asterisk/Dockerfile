FROM antirek/astolua

RUN ls

ADD after_start.sh /after_start.sh

RUN ls; chmod +x /after_start.sh

CMD ["/after_start.sh"]